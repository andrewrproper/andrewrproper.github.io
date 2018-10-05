#!/usr/bin/perl


=head1 SYNOPSIS

  gen-img-thumbs.pl [options]

  generates thumbnail images for images under specific paths

	options:
	  --debug    # print debug output


=head1 CHANGES

   - 2018-09-01 - Created by Andrew R. Proper

=head1 LIMITATIONS

Maybe it would be better to write this in Ruby, since Jekyll uses Ruby? Then
this project would not require any Perl.

=head1 WARNINGS

This program will B<overwrite> target thumbnail files.

=head1 DEPENDENCIES

=head2 Perl

Tested with: Perl v5.14.2

(DWIM Perl, under Windows)

=head2 Image Magick

Tested with:

Version: ImageMagick 7.0.7-6 Q16 x64 2017-10-04 http://www.imagemagick.org

=cut


use strict;
use warnings;

use feature 'say';
use FindBin;
use File::Find;
use Carp;
use Getopt::Long;
use YAML;
use Text::Wrap;
$Text::Wrap::columns = 120;


my $debug = 0;
GetOptions(
	'debug'	=> \$debug,
);

main();

sub main {

  my %config = load_config();

	# BEGIN - settings, from config

	# make target paths relative to this program's location
	my @target_paths = ();
  if ( ref $config{target_paths} eq 'ARRAY' ) {
    foreach my $path ( @{ $config{target_paths} } ) {
      my $v = $FindBin::Bin.'/'.$path;
      $v =~ s{//+}{/}gs;
      push @target_paths, $v;
    }
	}

  if ( ! @target_paths ) {
		Carp::confess( 'FATAL - failed to load target_paths from config' );
  }

	# You can use a larger thumb_size_scale in order to cause the edges of the
	# resulting image to be trimmed by the smaller thumb_size_crop value.
	my $thumb_size_scale       = $config{thumb_size_scale};
	my $thumb_size_crop        = $config{thumb_size_crop};

  my $thumb_small_enabled    = $config{thumb_small_enabled};
	my $thumb_small_size_scale = $config{thumb_small_size_scale};
	my $thumb_small_size_crop  = $config{thumb_small_size_crop};

	my $is_jpeg_suffix_re_str = $config{is_jpeg_suffix_re_str} || '.+\.jpg$';
	my $is_thumb_re_str       = $config{is_thumb_re_str}       || '\-thumb';
	my $match_2_depths_re_str = $config{match_2_depths_re_str} || '/images/[^/]+/[^/]+';

	my $is_jpeg_suffix_re = qr/$is_jpeg_suffix_re_str/;
	my $is_thumb_re       = qr/$is_thumb_re_str/;
	my $match_2_depths_re = qr/$match_2_depths_re_str/;

	# END - settings

	say "";
	say "generating thumbnails for images in paths:";
	say "  $_" for @target_paths;

	my $processed_count = 0;

	# search down through the subfolders of these paths, for files/dirs
	File::Find::find(  # see: perldoc File::Find
		sub {
			my $parent_dir 	= $File::Find::dir;
			my $full_fn 		= $File::Find::name;
			my $rel_fn 			= $_; # not used yet but may become useful

			if ( 
				# if $full_fn points to file (not a dir)
				-f $full_fn &&  

				# if it has a jpeg suffix
				$full_fn =~ $is_jpeg_suffix_re && 

				# if it does not match a thumb filename
				$full_fn !~ $is_thumb_re 
			) {

				if ( $parent_dir !~ $match_2_depths_re ) {
					debug( "SKIP - not 2 depths: $parent_dir - $rel_fn" );
				} else {

          # === thumbnail (large)

					# make a thumbnail filename, based on the source filename
					my $thumb_fn = $full_fn;
					$thumb_fn =~ s/(\.[^\.]+)$/-thumb$1/; # add a string just before the '.jpg' portion

					# create an ImageMagick command-line command
					my $cmd = qq(magick ). 
						# source image filename
						qq("$full_fn" ).
						# scale down to have smallest side fit this geometry
						qq(-thumbnail "$thumb_size_scale^" ). 
						# keep image centered when scaling down
						qq(-gravity center ).
						# trim image down to this geometry, after scale down by -thumbnail
						qq(-extent "$thumb_size_crop" ).  
						# output image filename
						qq("$thumb_fn" );

					run_cmd( $cmd );


          # === thumbnail (small)
          if ( $thumb_small_enabled ) {

            my $thumb_small_fn = $full_fn;
            $thumb_small_fn =~ s/(\.[^\.]+)$/-thumb-sm$1/; # add a string just before the '.jpg' portion

            # create an ImageMagick command-line command
            my $cmd = qq(magick ). 
              # source image filename
              qq("$full_fn" ).
              # scale down to have smallest side fit this geometry
              qq(-thumbnail "$thumb_small_size_scale^" ). 
              # keep image centered when scaling down
              qq(-gravity center ).
              # trim image down to this geometry, after scale down by -thumbnail
              qq(-extent "$thumb_small_size_crop" ).  
              # output image filename
              qq("$thumb_small_fn" );

            run_cmd( $cmd );
            $processed_count++;

          }

				}

			}

		},
		@target_paths,
	);


	say "";
	say "generated $processed_count thumbnail images";
	say "";

}



# run the command and verify it return OK (exit value: 0)
sub run_cmd {
	my $cmd = shift;
	debug( 'CMD: '.Text::Wrap::wrap( '', '  ', $cmd ) );
	my @out = qx( $cmd 2>&1 );
	my $exit_val = $? >> 8;
	if ( $exit_val ) {
		say 'OUT: '.$_ for @out;
		Carp::confess( 'FATAL - command ['.$cmd.']failed: '.$exit_val );
	}
}


# print the message as a DEBUG line, if $debug is enabled
sub debug {
	my $message = shift || '';
	if ( $debug ) {
		chomp $message;
		say 'DEBUG - '.$message;
	}
}


sub load_config {

  my $config_fn = $FindBin::Bin.'/gen-img-thumbs-config.yaml';

  my $ref = {};
  if ( -e $config_fn ) {
    $ref = YAML::LoadFile( $config_fn );
  }
  if ( ref $ref ne 'HASH' || ! %$ref ) {
		Carp::confess( 'FATAL - failed to load target_paths from config' );
  }

  return %$ref;
}




#!/usr/bin/perl

=head1 CHANGES

   - 2018-09-01 - Created by Andrew R. Proper

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

use FindBin;
use File::Find;
use Carp;
use feature 'say';

my $debug = 1;

my @target_paths = (
	$FindBin::Bin.'/images/art/',
	$FindBin::Bin.'/images/software/',
);
my $thumb_size = '250x250';
my $is_jpeg_suffix_re = qr/.+\.jpg$/;
my $is_thumb_re = qr/\-thumb/;

# search down through the subfolders of these paths, for files/dirs
File::Find::find( 
	sub {
		my $parent_dir 	= $File::Find::dir;
		my $full_fn 		= $File::Find::name;
		my $rel_fn 			= $_;

		if ( 
			-f $full_fn &&  # if $full_fn points to file (not a dir)
			$full_fn =~ $is_jpeg_suffix_re && # if it has a jpeg suffix
			$full_fn !~ $is_thumb_re  # if it does not match a thumb filename
		) {
			my $thumb_fn = $full_fn;
			$thumb_fn =~ s/(\.[^\.]+)$/-thumb$1/;
			# create an ImageMagick command-line command
			z:\personal\
			my $cmd = qq(magick "$full_fn" ).
				qq(-thumbnail "$thumb_size^" ).
				qq(-gravity center ).
				qq(-extent "$thumb_size" ).
				qq("$thumb_fn" );
			run_cmd( $cmd );
		}

	},
	@target_paths,
);


# run the command and verify it return OK (exit value: 0)
sub run_cmd {
	my $cmd = shift;
	debug( 'CMD: '.$cmd );
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

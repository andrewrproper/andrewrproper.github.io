---
layout: default
header:
  image_fullwidth: art/2018-06--art--diving-flame-expanded--1600x503.jpg
title: "Art"
breadcrumb: true
permalink: "art/"
---

<style type="text/css">
	/* 
	these classes, and the variables above, 
	can be moved to .scss at some point 
	*/

	.table {
    display: table;
  }
	.row {
    display: table-row;
	}
	.cell {
    display: table-cell;
    text-align: center;
  }


	li.gallery-img {
    padding: 0px;
    margin: 0px;
  }
	img.gallery-img {

		/* override setting from styles_feeling_responsive.css */
		border-radius: initial;
		-moz-border-radius: initial;
		-webkit-border-radius: initial;


    /* width: 100% of container box; stretch to fill */
    width: 100%;
    /* height auto allows image to keep aspect ratios as it resizes */
    height: auto;

		border: 3px solid black;
	}


  #images-wrapper {
    padding: 0.5em;
  }


</style>



{% assign folder = "/art/" %}
{% assign gallery_images = "" | split: "," %}
{% assign gallery_captions = "" | split: "," %}

{% assign reverse_files = site.static_files | reverse %}

{% for static_file in reverse_files %}
  {% if static_file.path contains folder %}
  	{% if static_file.basename contains "post-thumb" %}
    {% else %}
  	  {% if static_file.basename contains "thumb-sm" %}
		  {% else %}
  	  	{% if static_file.basename contains "-thumb" %}
  		 		{% if static_file.path contains "extra-ignore" %}
  				{% else %}
  
  				 	{% if static_file.extname == ".png" or static_file.extname == ".jpg" or static_file.extname == ".gif" %}
  
  						{% assign thumb_url = static_file.path | remove_first: "/images/" %}
  						{% assign image_caption = static_file.basename | remove_first: "-thumb"%}
  	
  						{% assign gallery_images = gallery_images | push: thumb_url %}
  						{% assign gallery_captions = gallery_captions | push: image_caption %}
  
  	 	 			{% endif %}
  	 			{% endif %}
 	 			{% endif %}
 	 		{% endif %}
  	{% endif %}
  {% endif %}
{% endfor %}



<div id="blog-index" class="row">
	<div class="small-12 columns t30">
		<h1>{{ page.title }}</h1>
		{% if page.teaser %}<p class="teaser">{{ page.teaser }}</p>{% endif %}

		<p>
    I enjoy creating art with a variety of approaches, including the use of 
    <a href="https://www.gimp.org/">GIMP</a>,
    <a href="https://krita.org/en/">Krita</a>,
    and other software.
    </p>


    <div id="images-wrapper">
    <div class="table">
    <div class="row">
    <div class="cell">


		<ul class="small-block-grid-3 medium-block-grid-5 large-block-grid-7">

			{% assign array_last_index = gallery_images | size | minus: 1 %}

			{% for index in ( 0..array_last_index ) %}

				{% capture thumb_url %}{{ gallery_images[ index ] }}{% endcapture %}

				{% assign split_url = thumb_url | split: '-thumb' %}
				{% capture image_url %}{{split_url[0]}}{{split_url[1]}}{% endcapture %}
	
				{% assign image_caption = gallery_captions[ index ] %}

          <li class="gallery-img"><a 
              data-fancybox="gallery"
              data-caption="{{ image_caption }}"
              href="{{ site.urlimg }}{{ image_url }}"
							class="gallery-img"
							title="{{ image_caption }}"
						><img 
							{% if include.show_caption %}
								{% if image_caption %}data-caption="{{ image_caption }}"{% endif %} 
							{% endif %}
							src="{{ site.urlimg }}{{ thumb_url }}" 
							alt="{{ image_caption }}"
							title="{{ image_caption }}"
							class="gallery-img"
						></a></li>
	
			{% endfor %}

		</ul>



		</div><!-- /.cell -->
		</div><!-- /.row -->
		</div><!-- /.table -->
    </div><!-- /#images-wrapper -->


	</div><!-- /.small-12.columns -->
</div><!-- /.row -->



[gimp]: https://www.gimp.org/
[krita]: https://krita.org/en/

<!-- vim: ts=2
-->

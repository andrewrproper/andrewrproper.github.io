---
layout: page
title: "Software"
teaser: ""
header:
  image_fullwidth: software/2018-06--software--1600.jpg
breadcrumb: true
permalink: "software/"

# Only use this <h1> if using the default layout. It is not needed for page
# layout:
#
#		<h1>{{ page.title }}</h1>
#		{% if page.teaser %}<p class="teaser">{{ page.teaser }}</p>{% endif %}
---


<div class="row">
	<div class="small-12 columns t30">

			{% assign counter = 1 %}

			{% assign show_posts = site.posts | where_exp: "item", "item.categories contains 'Software'" %}
			{% for post in show_posts %}

        <h2><a href="{{ site.url }}{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h2>
        <p>

          {% if post.image.thumb %}<a 
            href="{{ site.url }}{{ site.baseurl }}{{ post.url }}" 
            title="{{ post.title | escape_once }}"><img 
            src="{{ site.urlimg }}{{ post.image.thumb }}" 
            class="alignleft" 
            width="150" 
            height="150" 
            alt="{{ post.title | escape_once }}"></a>{% endif %}
  
          <small>

	          {% if post.subheadline %}
	          <i>{{ post.subheadline }}</i>
	          {% endif %}
	
	  				{% if post.date %}
	  				<time 
	            class="icon-calendar pr20" 
	            style=" padding-left: 2em; "
	            datetime="{{ post.date | date_to_xmlschema }}" 
	            itemprop="datePublished"> {{ post.date | date: "%Y-%m-%d" }}</time>
	  				{% endif %}

    				{% if post.categories != empty %}<span 
	            style=" padding-left: 2em; "
              class="icon-archive pr20"> {{ post.categories | join: ' · ' | upcase }}{% endif %}</span>

				    <span 
	            style=" padding-left: 2em; "
              class="pr20">{% for tag in post.tags %}<span 
              class="icon-price-tag pr10"> {{tag}}</span> {% endfor %}</span>

          </small>

          {% if post.excerpt %}{{ post.excerpt }}{% endif %} <br/> <a 
            href="{{ site.url }}{{ site.baseurl }}{{ post.url }}" 
            title="{{ site.data.language.read }} {{ post.title | escape_once }}"
            ><strong>{{ site.data.language.read_more }}</strong></a>

        </p>


				{% assign counter=counter | plus:1 %}
			{% endfor %}

	</div><!-- /.small-12.columns -->
</div><!-- /.row -->




<!-- vim: ts=2
-->

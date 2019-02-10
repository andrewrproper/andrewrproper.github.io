---
layout: page
#
# Content
#
subheadline: ""
title: "SplatterBoardManip"
teaser: "A painting and image manipulation program created using C++, OpenGL, and QT3."
categories:
   - Software
tags:
   - Graphics
   - Art 
   - GUI
excerpt_separator: <!-- more -->
header:
  image_fullwidth: software/2018-06--software--1600.jpg
breadcrumb: true
#
# Styling
#
#image:
#  header: ""
#  thumb: ""
#  homepage: ""
#  caption: ""
#  url: ""
---


Copyright 2002 Andrew R. Proper

<a href="https://github.com/andrewrproper/SplatterBoardManip" class="icon-github" title="View it on GitHub" >&nbsp; View it on GitHub</a>


---

SplatterBoardManip features drawing tools including point, line, 
square, circle, and triangle. It also features image manipulation 
tools which filter the image to create a unique result. The drawing 
tools have adjustable colour, brush size, and gradient degree. The 
image created can be saved in common image formats, and can be 
re-opened later for further modification.
 
<!-- more -->

This program was written for my Computer Graphics class in 2002. In this 
class my final grade was 99%. I thoroughly enjoy graphics programming.


---

![Drawing with the drawing tools.](/assets/img/posts/software/splatterboardmanip/figure-1.png)

*Drawing with the drawing tools.*

---

![The image manipulation tools were used to edge-detect, blur, lap-of-gauss, and fade the image.](/assets/img/posts/software/splatterboardmanip/figure-2.png)

*The image manipulation tools were used to edge-detect, blur, lap-of-gauss, and fade the image.*


---

![Multiple intensifies bring the colours more into the foreground.](/assets/img/posts/software/splatterboardmanip/figure-3.png)

*Multiple intensifies bring the colours more into the foreground.*


---

![More lap-of-gauss and edge detection clarifies the image.](/assets/img/posts/software/splatterboardmanip/figure-4.png)

*More lap-of-gauss and edge detection clarifies the image.*


---

![Dimming using fade.](/assets/img/posts/software/splatterboardmanip/figure-5.png)

*Dimming using fade.*


---

![Adding lines and rectangles with drawing tools, then inverting the image.](/assets/img/posts/software/splatterboardmanip/figure-6.png)

*Adding lines and rectangles with drawing tools, then inverting the image.*


---



## Dependencies

  - C++ compiler
  - OpenGL
  - QT3

## Compiling

To compile and run this program
type ```qmake splatterBoardManip.pro``` and then ```make```.

qmake will read the splatterBoardManip.pro file
and generate an appropriate makefile.




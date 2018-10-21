

/* NOTES
 *    - don't use the min version of js files because webpack will minify and
 *      needs non-min versions to be able to parse.
 *
 */

require( "jquery" ); // dependency of: fancybox

require( "@fancyapps/fancybox" );
require( "@fancyapps/fancybox/dist/jquery.fancybox.css" );

/*
require( "./portfolio-art.scss" );
*/


var fancybox_options = {

  // Close existing modals
  // Set this to false if you do not need to stack multiple instances
  closeExisting: false,

  // Enable infinite gallery navigation
  loop: true,

  // Horizontal space between slides
  gutter: 50,

  // Enable keyboard navigation
  keyboard: true,

  // Should allow caption to overlap the content
  preventCaptionOverlap: true,

  // Should display navigation arrows at the screen edges
  arrows: true,

  // Should display counter at the top left corner
  infobar: true,

  // Should display close button (using `btnTpl.smallBtn` template) over the content
  // Can be true, false, "auto"
  // If "auto" - will be automatically enabled for "html", "inline" or "ajax" items
  smallBtn: "auto",

  // Should display toolbar (buttons at the top)
  // Can be true, false, "auto"
  // If "auto" - will be automatically hidden if "smallBtn" is enabled
  toolbar: "auto",

  // What buttons should appear in the top right corner.
  // Buttons will be created using templates from `btnTpl` option
  // and they will be placed into toolbar (class="fancybox-toolbar"` element)
  buttons: [
    "zoom",
    //"share",
    "slideShow",
    "fullScreen",
    //"download",
    "thumbs",
    "close"
  ],

  // Detect "idle" time in seconds
  idleTime: 3,

  // Disable right-click and use simple image protection for images
  protect: false,

  // Shortcut to make content "modal" - disable keyboard navigtion, hide buttons, etc
  modal: false,

  image: {
    // Wait for images to load before displaying
    //   true  - wait for image to load and then display;
    //   false - display thumbnail and load the full-sized image over top,
    //           requires predefined image dimensions (`data-width` and `data-height` attributes)
    preload: true
  },

  // Default content type if cannot be detected automatically
  defaultType: "image",

  // Open/close animation type
  // Possible values:
  //   false            - disable
  //   "zoom"           - zoom images from/to thumbnail
  //   "fade"
  //   "zoom-in-out"
  //
  animationEffect: "zoom",

  // Duration in ms for open/close animation
  animationDuration: 366,

  // Should image change opacity while zooming
  // If opacity is "auto", then opacity will be changed if image and thumbnail have different aspect ratios
  zoomOpacity: "auto",

  // Transition effect between slides
  //
  // Possible values:
  //   false            - disable
  //   "fade'
  //   "slide'
  //   "circular'
  //   "tube'
  //   "zoom-in-out'
  //   "rotate'
  //
  transitionEffect: "fade",

  // Duration in ms for transition animation
  transitionDuration: 366,

  // Container is injected into this element
  parentEl: "body",

  // Hide browser vertical scrollbars; use at your own risk
  hideScrollbar: false,

  // Focus handling
  // ==============

  // Try to focus on the first focusable element after opening
  autoFocus: true,

  // Put focus back to active element after closing
  backFocus: true,

  // Do not let user to focus on element outside modal content
  trapFocus: true,

  // Module specific options
  // =======================

  fullScreen: {
    autoStart: false
  },

  // Set `touch: false` to disable panning/swiping
  touch: {
    vertical: true, // Allow to drag content vertically
    momentum: true // Continue movement after releasing mouse/touch when panning
  },

  slideShow: {
    autoStart: false,
    speed: 3000
  },

  thumbs: {
    autoStart: false, // Display thumbnails on opening
    hideOnClose: true, // Hide thumbnail grid when closing animation starts
    parentEl: ".fancybox-container", // Container is injected into this element
    axis: "y" // Vertical (y) or horizontal (x) scrolling
  },

  // Use mousewheel to navigate gallery
  // If 'auto' - enabled for images only
  wheel: "auto",


 
  // Custom options when mobile device is detected
  // =============================================

  mobile: {
    preventCaptionOverlap: false,
    idleTime: false,
  }

};


$( document ).ready( function () {
  console.log("BEGIN - init fancybox on " + $('[data-fancybox="gallery"]').length + " elements" );

  $('[data-fancybox="gallery"]').fancybox( fancybox_options );

  console.log("END - init fancybox");
} );



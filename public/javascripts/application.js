// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// = require gmap3.js
$(document).ready(function() {
  //$("input").example(function() {return $(this).attr("title");});
  var bg_image = $("#search_wrapper").attr('class');
  $("#search_wrapper").css('background-image', "url(/images/" + bg_image + ".jpg)");
});
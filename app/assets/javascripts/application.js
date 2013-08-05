// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui.min
//= require chosen.jquery.min
//= require_tree .

$(document).ready(function(){
  
  $('#date-picker').datepicker();

  $('#query_page_id').chosen();

  $('#booking_client_id').chosen();
    // {no_results_text: "Oops, nothing found!"}

  if($('.dir-page').length) {
    $('.dir-search').on('keyup', function(){
      var v = $(this).val();
      if(v != '') {
        // typed
        $(this).closest('.dir-page').addClass('filter-mode');
        $('.alpha-letter').hide();
      } else {
        // reset
        $(this).closest('.dir-page').removeClass('filter-mode');
        $('.alpha-letter').show();
      }
      $('.alpha-list li').each(function(){
        $(this).find('a:not(:contains('+v+'))').each(function(){
          $(this).hide();
        });
        $(this).find('a:contains('+v+')').each(function(){
          $(this).show();
          $(this).closest('.section-alpha').find('.alpha-letter').show();
        });
      });
    });
  }



});
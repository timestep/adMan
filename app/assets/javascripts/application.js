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
$.extend($.expr[':'], {
  'containsi': function(elem, i, match, array)
  {
    return (elem.textContent || elem.innerText || '').toLowerCase()
    .indexOf((match[3] || "").toLowerCase()) >= 0;
  }
});

$(document).ready(function(){
  
  if($('#date-picker').length){
    $('#date-picker').datepicker(); 
  }

  if($('#query_page_id').length){
    $('#query_page_id').chosen();
  }

  if($('#booking_client_id').length){
    $('#booking_client_id').chosen();
  }

// Modal Functions
  var modalClose = function(){
    $('.modal-cover').removeClass('active');
    $('body').removeClass('modal-lock');
  }

  var modalBoxCloseable = function() {
    $('.adm-modal-box').append('<div class="modal-close">X</div>');
    $('.modal-close').on('click', function(){
      modalClose();
    });
  }

  if($('.adm-directory').length) {
    $('body').append('<div class="cover modal-cover"></div>');

    var dirModalFetch = function(url, className, idName) {
      $('.alpha-list-item a').on('click', function(){
        var id = $(this).parent().data('item-id');
        $.ajax({
          url: url+id+"/edit",
          context: document.body,
          success: function(data) {
            var item = $(data).find(".adm-modal-box");
            $('.modal-cover').addClass('active');
            $('body').addClass('modal-lock');
            $('.modal-cover').html(item);
            modalBoxCloseable();
            $('.'+className).each(function(){
              $(this).find('.adm-button').on('click', function(){
                modalClose();
                var updatedName = $('#'+idName).val();
                $('.item-id-'+id).find('a').text(updatedName);
              });
              $(this).on('click', function(event){
                event.stopPropagation();
              });
            });       
          }
        });
      });      
    }


    $('.dir-search').on('keyup', function(){
      var v = $(this).val();
      if(v != '') {
        // typed
        $('.dir-listing').addClass('filter-mode');
        $('.alpha-letter').hide();
      } else {
        // reset
        $('.dir-listing').removeClass('filter-mode');
        $('.alpha-letter').show();
      }
      $('.alpha-list li').each(function(){
        $(this).find('a:not(:containsi('+v+'))').each(function(){
          $(this).hide();
        });
        $(this).find('a:containsi('+v+')').each(function(){
          $(this).show();
          $(this).closest('.section-alpha').find('.alpha-letter').show();
        });
      });
    });    
    if($('.dir-page').length) {
      var url = '/pages/';
      var className = 'page-info-edit';
      var idName = 'page_name';
      dirModalFetch(url, className, idName);
    }
    if($('.dir-client').length) {
      var url = '/clients/';
      var className = 'client-info-edit';
      var idName = 'client_name';
      dirModalFetch(url, className, idName);
    }
    $('.modal-cover').on('click', function(){
      modalClose();
    });
  }

  $.support.selectstart = "onselectstart" in document.createElement("div");
  $.fn.disableSelection = function() {
    return this.bind( ( $.support.selectstart ? "selectstart" : "mousedown" ) +
        ".ui-disableSelection", function( event ) {
        event.preventDefault();
    });
  };

  if($('.calendar').length){
    $(this).disableSelection();
    $('td').on('dblclick', function(){
      var id = $(this).find('.calendar-day').data('day');
      console.log(id);
    });
  }


});
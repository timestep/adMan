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
  
  if($('#date-picker').length){
    $('#date-picker').datepicker(); 
  }

  if($('#query_page_id').length){
    $('#query_page_id').chosen();
  }

  if($('#booking_client_id').length){
    $('#booking_client_id').chosen();
  }

  if($('.adm-directory').length) {
    $('body').append('<div class="cover modal-cover"></div>');
    var closeModal = function(){
      $('.modal-cover').removeClass('active');
      $('body').removeClass('modal-lock');
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
        $(this).find('a:not(:contains('+v+'))').each(function(){
          $(this).hide();
        });
        $(this).find('a:contains('+v+')').each(function(){
          $(this).show();
          $(this).closest('.section-alpha').find('.alpha-letter').show();
        });
      });
    });
    $('.alpha-list-item a').on('click', function(){
      var id = $(this).parent().data('item-id');
      $.ajax({
        url: "/pages/"+id+"/edit",
        context: document.body,
        success: function(data) {
          var item = $(data).find(".adm-midfloat-box");
          $('.modal-cover').addClass('active');
          $('body').addClass('modal-lock');
          $('.modal-cover').html(item);
          $('.page-info-edit').each(function(){
            $(this).find('.adm-button').on('click', function(){
              closeModal();
              var updatedName = $('#page_name').val();
              $('.item-id-'+id).find('a').text(updatedName);
            });
            $(this).on('click', function(event){
              event.stopPropagation();
            });
          });       
        }
      });
    });

    $('.modal-cover').on('click', function(){
      closeModal();
    });
  }



});
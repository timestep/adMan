// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
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

            // $('.' + className)
            //   .on('click', function() {
            //     // Whatever this event handler does
            //   })            
            //   .find('.adm-button')
            //   .on('click', function() {
            //     // Whatever this event handler does
            //   });

            // $('<div></div>')
            //   .attr('class', 'example')
            //   .append('<a></a>')
            //     .attr('href', '#')
            //     .end()
            //   .appendTo(document.body);

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
    $(document).disableSelection();

/// vvvvvvvvv WILL NEED TO REFACTOR THIS INTO ONE FUNCTION!!! vvvvvvvvv ////
    $('.adm-calendar-container').on('click', '.adm-arrow.cal-back', function(){
      var dateMonth = $(this).data('month');
      var dateYear = $(this).data('year');
      console.log(dateMonth);
      console.log(dateYear);

      $.ajax({
        url: "/bookings?month="+dateYear+"-"+dateMonth,
        success: function(data) {
          console.log(url);
          console.log(data);
          var item = $(data).find(".calendar");
          $('.adm-calendar-container').html(item);
        }
      });

    });


    $('.adm-calendar-container').on('click', '.adm-arrow.cal-forward', function(){
      var dateMonth = $(this).data('month');
      var dateYear = $(this).data('year');
      console.log(dateMonth);
      console.log(dateYear);

      $.ajax({
        url: "/bookings?month="+dateYear+"-"+dateMonth,
        success: function(data) {
          console.log(url);
          console.log(data);
          var item = $(data).find(".calendar");
          $('.adm-calendar-container').html(item);
        }
      });

    });
/// ^^^^^^^   WILL NEED TO REFACTOR THIS INTO ONE FUNCTION!!! ^^^^^^  ////

    $('.adm-calendar-container').on('click', '.calendar td', function(){
      var dateDay = $(this).find('.calendar-day').data('day');
        if(dateDay < 10){ 
          var dateDay = '0'+dateDay;
          console.log(dateDay);
        }
        else{
        console.log(dateDay);
        }
      var dateMonth = $(this).find('.calendar-day').data('month');
        if(dateMonth < 10){
          var dateMonth = '0'+dateMonth;
          console.log(dateMonth);
        }
        else{
          console.log(dateMonth)
        }
      var dateYear = $(this).find('.calendar-day').data('year');
        if (dateYear < 10){
          var dateYear = '000'+dateYear;
          console.log(dateYear);
        }
        else {
          console.log(dateYear);          
        }
        bkListSlideIn();
      // document.location.href = "/bookings/day/"+dateMonth+"-"+dateDay+"-"+dateYear;
      // });

      $.ajax({
        url: "/bookings/day/"+dateMonth+"-"+dateDay+"-"+dateYear,
        context: document.body,
        success: function(data) {
          console.log("success");
          var item = $(data).find(".single-day-booking-info");
          $('.adm-sidekick-1 .sidekick-content').html(item);
          $('.adm-sidekick-1 .sidekick-content').on('click', '.date-header', function(){
            bkListSlideOut();
          });
        }     
      });

      $('.adm-sidekick-1').on('click', '.booking-list-item', function(){
        var bookingId = $(this).data('bookingid');
        $.ajax({
          url: '/bookings/'+bookingId,
          context: document.body,
          success: function(data) {
            var item = $(data).find('.booking-list-item-container');
            $('.adm-sidekick-2').find('.booking-list-wrapper').html(item);
            bkListSlideIn2();
          }
        });
      });


    });
  }

  // Functions to load and remove the first sidekick //
  var bkListSlideIn = function(){
    $('.container').addClass('adm-slideout');
    console.log('slide in');
  }

  var bkListSlideOut = function(){
    $('.container').removeClass('adm-slideout');
    // $('.calendar').addClass('adm-cal-move')
    console.log('slide out');
  }


  // Functions to load the second sidekick //
  var bkListSlideIn2 = function(){
    $('.container').addClass('adm-slideout-2');
    console.log('#2 slider is in view!');
  }

  var bkListSlideOut2 = function(){
    $('.container').removeClass('adm-slideout-2');
    console.log('#2 slid away!');
  }



});
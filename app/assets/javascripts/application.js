// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
//= require filterrific/filterrific-jquery
//= require moment
//= require bootstrap-datetimepicker

function formatDate(date) {
  var dayNames = [
    "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
  ]

  var monthNames = [
    "January", "February", "March", "April", "May", "June", "July", "August",
    "September", "October", "November", "December"
  ];

  var weekday = dayNames[date.getDay()]
  var day = date.getDate();
  var month = monthNames[date.getMonth()];
  var year = date.getFullYear();

  return weekday + ', ' + month + ' ' + day + ', ' + year;
}

document.addEventListener("gtm.load", function() {
  var url = event.data.url;
  dataLayer.push({
    'event':'pageView',
    'virtualUrl': url
  });
})

document.addEventListener("turbolinks:load", function() {
  $('td.day').on('click', function(e) {
    $('td.day').removeClass('active')
    $(e.currentTarget).addClass('active')
    e.preventDefault();
    // Get data-date of inner date element
    var dateStr = $(e.currentTarget).find('.date')[0].dataset.date;
    var date = new Date(dateStr);
    // Get and parse json
    $.getJSON("/events.json?start_date=" + dateStr, function(data) {
      // clear sidebar
      $('.panel-date').html('');
      $('.calendar-sidebar .panel-body').html('');
      // add date
      $('.panel-date').html(
        '<h3 class="text-center">' + formatDate(date) + '</h3>'
      );

      $('.calendar-sidebar').addClass('display-events');

      if (data.length === 0) {
        $('.calendar-sidebar .panel-body').html('<center class="text-center">There are no events today.</center>');
        return;
      };

      standardEvents = []
      allDayEvents = []

      $.each(data, function(i) {
        var event = data[i];
        if (event.all_day || Date.parse(event.event_date) < date) {
          allDayEvents.push(htmlStrFromEvent(event, date))
        } else {
          standardEvents.push(htmlStrFromEvent(event, date))
        }
      });

      if (allDayEvents.length === 0) { // no all eay events
        $('.calendar-sidebar .panel-body').html(
          standardEvents.join(' ')
        );
      } else {
        $('.calendar-sidebar .panel-body').html(
          '<div class="col-xs-7 hour-events">' + standardEvents.join(' ') + '</div>' +
          '<div class="col-xs-5 all-day-events">' +
          '<h5 class="text-center">All Day Events</h5>' +
          allDayEvents.join(' ') +
          '</div>'
        );
      }
    });
  });

  function htmlStrFromEvent(event, currdate) {
    htmlStr = "";
    htmlStr += '<div class="row event-item-row">'
    if (event.all_day || Date.parse(event.event_date) < currdate) {
      htmlStr += '  <div class="col-xs-12 day-view event">'
      htmlStr += '    <strong>' + event.title + '</strong><br>'
      htmlStr +=      event.location
      htmlStr += '    <a href="/events/' + event.id + '" class="pull-right more"><em>more&nbsp</em>&#10140</a>'
      htmlStr += '  </div>'
    } else {
      var date = new Date(event.start_date);
      var suffix = (date.getHours() >= 12)? 'pm' : 'am';
      var h = ((date.getHours() + 11) % 12 + 1);
      htmlStr += '  <div class="col-xs-3 day-view time">'
      htmlStr += h + '<sup>&nbsp;' + suffix + '</sup>'
      htmlStr += '  </div>'
      htmlStr += '  <div class="col-xs-9 day-view event">'
      htmlStr += '    <strong>' + event.title + '</strong><br>'
      htmlStr +=      event.location
      htmlStr += '    <a href="/events/' + event.id + '" class="pull-right more"><em>more&nbsp</em>&#10140</a>'
      htmlStr += '  </div>'
    }
    htmlStr += '</div>'
    return htmlStr;
  }

  if (window.location.pathname == '/events/new') {
    $('.calendar-sidebar').addClass('new-event');
  }

  // Clear current week and select correct week on first load
  $('.current-week').removeClass('current-week');
  $('tr:has(td.today)').addClass('current-week');

  // Create previous and next links for week view on mobile
  $('.calendar-heading a:contains("Previous")').addClass('month');
  $('.calendar-heading a:contains("Next")').addClass('month');
  $('.calendar-heading').prepend('<a class="week week-prev-next prev">Previous</a>');
  $('.calendar-heading').append('<a class="week week-prev-next next">Next</a>');

  // Previous links
  $('.week-prev-next.prev').on('click', function(e) {
    if ($('.current-week').prev().is('tr:first-child')) {
      $('.week-prev-next.prev').removeClass('week-prev-next');
      $('.calendar-heading a.month:contains("Previous")').addClass('month-prev-next prev');
    }
    var prev = $('.current-week').prev();
    $('.current-week').removeClass('current-week');
    prev.addClass('current-week');
  });

  // Go to previous month
  $('.calendar-heading a.month:contains("Previous")').on('click', function(e) {
    $('.current-week').removeClass('current-week');
    document.addEventListener('turbolinks:load', function(e) {
      e.target.removeEventListener(e.type, arguments.callee);
      $('tr:has(td.today)').removeClass('current-week');
      $('tr').last().addClass('current-week');
      $('.week-prev-next.next').removeClass('week-prev-next');
      $('.calendar-heading a.month:contains("Next")').addClass('month-prev-next next');
    });
  });

  // Next links
  $('.week-prev-next.next').on('click', function(e) {
    if ($('.current-week').next().is('tr:last-child')) {
      $('.week-prev-next.next').removeClass('week-prev-next');
      $('.calendar-heading a.month:contains("Next")').addClass('month-prev-next next');
    }
    var next = $('.current-week').next();
    $('.current-week').removeClass('current-week');
    next.addClass('current-week');
  });

  // Go to next month
  $('.calendar-heading a.month:contains("Next")').on('click', function(e) {
    $('.current-week').removeClass('current-week');
    document.addEventListener('turbolinks:load', function(e) {
      e.target.removeEventListener(e.type, arguments.callee);
      $('tr:has(td.today)').removeClass('current-week');
      $('tbody').find('tr').first().addClass('current-week');
      $('.week-prev-next.prev').removeClass('week-prev-next');
      $('.calendar-heading a.month:contains("Previous")').addClass('month-prev-next prev');
    });
  });
});

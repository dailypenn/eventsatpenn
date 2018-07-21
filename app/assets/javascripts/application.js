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

function updateCal() {
  return function() {
    $('td.day').on('click', function(e) {
      var date = e.target.children[0].dataset.date
      console.log(date);
      Turbolinks.visit(`/events/day/${date}`)
    })

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
      } else {
        $('.week.next').addClass('week-prev-next');
        $('.month-prev-next.next').removeClass('month-prev-next');
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
      } else {
        $('.week.prev').addClass('week-prev-next');
        $('.month-prev-next.prev').removeClass('month-prev-next');
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
  }
};

$(document).on('turbolinks:load', updateCal());
$(document).on('filtered', updateCal());

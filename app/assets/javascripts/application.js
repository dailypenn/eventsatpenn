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

  return weekday + ' ' + month + ' ' + day + ', ' + year;
}

$(document).ready(function() {
  $('td.day').on('click', function(e) {
    $('td.day').removeClass('active')
    $(e.target).addClass('active')
    e.preventDefault();
    // Get data-date of inner date element
    var dateStr = $(e.target).find('.date')[0].dataset.date;
    var date = new Date(dateStr);
    // Get and parse json
    $.getJSON("/events.json?start_date=" + dateStr, function(data) {
      var htmlStr = '';
      if (data.length == 0) {
        htmlStr += 'There are no events today!'
      };

      $.each(data, function(i) {
        var event = data[i];
        htmlStr += '<div>'
        htmlStr += '<strong>' + event.title + '</strong> '
        htmlStr += '<em>' + event.location + '</em>'
        htmlStr += '</div>'
      });

      $('.panel-date').html('');
      $('.panel-date').html(
        '<h3 class="text-center">' + formatDate(date) + '</h3>'
      );
      $('.calendar-sidebar .panel-body').html('');
      $('.calendar-sidebar .panel-body').html(
        htmlStr
      );
      $('.calendar-sidebar')[0].className += ' display-events';
    });
  });
});

// Pushes a "pageview" event to the GTM dataLayer
document.addEventListener('turbolinks:load', function(event) {
  if (typeof ga === 'function') { // if GA enabled, send
    ga('set', 'location', event.data.url);
    ga('set', 'page', window.location.pathname);
    return ga('send', 'pageview');
  }
});

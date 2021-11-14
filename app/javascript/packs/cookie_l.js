$(document).on('cl:not_accepted', function() {
    // This function will be called when a user visits your page but has not accepted
    // cookie policy. This is the right place (if needed) to use anonymous tracking/profiling system
});
$(document).on('cl:ready', function() {
    // This function will be called only when the users accepts the cookie policy
    // with one of the allowed method.
    // Will also be called after every document.ready function if the policy has been accepted.
    // This is the right place to trigger Google Analytics track page, for example
});

$(document).on('cl:page_change', function() {
    // If your application uses Turbolinks, this event will be triggered after every
    // 'page:change' Turbolinks event
});
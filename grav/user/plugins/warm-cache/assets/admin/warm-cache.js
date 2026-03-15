$(document).on('click', '[data-warm-cache-useraction="warm-cache"]', function(event) {
    event.preventDefault();
    var target = $(event.currentTarget);
    var Toastr = Grav.default.Utils.toastr;
    var URI = target.data('warm-cache-uri') || GravAdmin.config.current_url;

    var icon = target.find('.fa:first');
    var backup = icon.attr('class');

    icon.attr('class', 'fa fa-fw fa-refresh fa-spin');
    $.post(URI, {
        task: 'warmCache',
        'admin-nonce': GravAdmin.config.admin_nonce,
    }, function(response) {
        icon.attr('class', backup);

        if (response.status === 'error') {
            Toastr.error(response.message);
            return false;
        }

        Toastr.success(response.message);
    });
});

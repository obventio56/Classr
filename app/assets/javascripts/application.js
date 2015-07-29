// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require polymer/webcomponents
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function add_fields(link, association, content) {

    $(link).parent().before(content.replace(regexp, new_id));
}
function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}


$(document).ready( function(){

    $('.add_fields').click( function() {
        var association = $(this).data('add-what')
        var new_id = new Date().getTime();
        var regexp = new RegExp("new_" + association, "g");
        cloneableHTML = $('.' + association + '_fields').html().replace(regexp, new_id);
        $('.' + association + '_list').append(cloneableHTML)
    });

    $('.destroy').on('click', function() {
        var $modelDisplay = $(this).closest('.model_display');
        add_destroy_fields($modelDisplay.data('path-in-params'));
        $modelDisplay.hide()
    });
    $('.edit').on('click', function() {
        var $modelDisplay = $(this).closest('.model_display');
        display_edit_fields($modelDisplay.data('path-in-params'));
        $modelDisplay.hide()
    });
});

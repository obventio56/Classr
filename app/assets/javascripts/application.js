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
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $('.edit_school').append(content.replace(regexp, new_id));
}

function add_destroy_fields(contextString) {
    var contextArray = contextString.split('-');

    var formSelector = contextArray.shift();
    var fieldName = contextArray[0] + '[' + contextArray.slice(1, contextArray.length).join('][') + ']';
    var fieldId = contextArray.join('_');

    $(formSelector).append('<div class="fields"><input type="hidden" name="' + fieldName + '[_destroy]' + '" id="' + fieldId  + '__destroy' + '" value="1"/><input type="hidden" name="' + fieldName + '[id]' + '" id="' + fieldId  + '_id' + '" value="' + contextArray.pop() + '"/></div>')
}

function display_edit_fields(contextString) {
    var modelId = contextString.split('-').pop();
    $('input[type=hidden][value=' + modelId + ']').prev().css('display', 'inline');

}

$(document).ready( function(){
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

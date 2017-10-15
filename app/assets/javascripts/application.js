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
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {


    $('#sex_check').change(function(){
        if ($(this).is(':checked')) {
            $('#sex-result').slideDown(200);
            $('.sex_check_label').css({
                'background-color': '#FC7BA2'
        });
        } else {
            $('#sex-result').slideUp(200);
            $('.sex_check_label').css({
                'background-color': '#FFF',
            });

            $('.sex_type').prop('checked', false);
        }
    });

    $('#seiri_check').change(function(){
        if ($(this).is(':checked')) {
            $('.seiri_check_label').css({
                'background-color': '#F26574',
            });
        } else {
            $('.seiri_check_label').css({
                'background-color': '#FFF',
            });
        }
    });

    $('#feel_type_fine').change(function(){
        if ($(this).is(':checked')) {
            $('.feel_type_label').css({
                'background-color': '#FFF',
            });
            $('.feel_type_fine').css({
                'background-color': '#FC7BA2'
            });
        } else {
            $('.feel_type_fine').css({
                'background-color': '#FFF',
            });
        }
    });


    $('#feel_type_like').change(function(){
        if ($(this).is(':checked')) {
            $('.feel_type_label').css({
                'background-color': '#FFF',
            });
            $('.feel_type_like').css({
                'background-color': '#FC7BA2'
            });
        } else {
            $('.feel_type_like').css({
                'background-color': '#FFF',
            });
        }
    });


    $('#feel_type_soso').change(function(){
        if ($(this).is(':checked')) {
            $('.feel_type_label').css({
                'background-color': '#FFF',
            });
            $('.feel_type_soso').css({
                'background-color': '#FC7BA2'
            });
        } else {
            $('.feel_type_soso').css({
                'background-color': '#FFF',
            });
        }
    });


    $('#feel_type_bad').change(function(){
        if ($(this).is(':checked')) {
            $('.feel_type_label').css({
                'background-color': '#FFF',
            });
            $('.feel_type_bad').css({
                'background-color': '#FC7BA2'
            });
        } else {
            $('.feel_type_bad').css({
                'background-color': '#FFF',
            });
        }
    });




    $('.feel_type').on('click', function() {
        if ($(this).prop('checked')){
            $('.feel_type').prop('checked', false);
            $(this).prop('checked', true);
        }
    });

    $('.condition_type').on('click', function() {
        if ($(this).prop('checked')){
            $('.condition_type').prop('checked', false);
            $(this).prop('checked', true);
        }
    });

    $('.sex_type').on('click', function() {
        if ($(this).prop('checked')){
            $('.sex_type').prop('checked', false);
            $(this).prop('checked', true);
        }
    });


});

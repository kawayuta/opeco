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
        $('#today_data').submit();
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
        $('#today_data').submit();

    });


    $('#feel_type_soso').change(function(){
        if ($(this).is(':checked')) {
            $('.feel_type_label').css({
                'background-color': '#FFF',
            });
            $('.feel_type_soso').css({
                'background-color': '#94DEF9'
            });
        } else {
            $('.feel_type_soso').css({
                'background-color': '#FFF',
            });
        }
        $('#today_data').submit();

    });


    $('#feel_type_bad').change(function(){
        if ($(this).is(':checked')) {
            $('.feel_type_label').css({
                'background-color': '#FFF',
            });
            $('.feel_type_bad').css({
                'background-color': '#CAABE0'
            });
        } else {
            $('.feel_type_bad').css({
                'background-color': '#FFF',
            });
        }
        $('#today_data').submit();

    });



    $('#sex_type_ari').change(function(){
        if ($(this).is(':checked')) {
            $('.sex_type_label').css({
                'background-color': '#FFF',
            });
            $('.sex_type_check ').css({
                'background-color': '#FC7BA2',
                'color': '#FFF'
            });
            $('.sex_type_check i').css({
                'color': '#FFF'
            });
            $('.sex_type_ari').css({
                'background-color': '#FC7BA2'
            });
        } else {
            $('.sex_type_ari').css({
                'background-color': '#FFF',
            });
        }
        $('#today_data').submit();

    });


    $('#sex_type_nasi_soto').change(function(){
        if ($(this).is(':checked')) {
            $('.sex_type_label').css({
                'background-color': '#FFF',
            });
            $('.sex_type_check ').css({
                'background-color': '#FC7BA2',
                'color': '#FFF'
            });
            $('.sex_type_check i').css({
                'color': '#FFF'
            });
            $('.sex_type_nasi_soto').css({
                'background-color': '#FC7BA2'
            });
        } else {
            $('.sex_type_nasi_soto').css({
                'background-color': '#FFF',
            });
        }
        $('#today_data').submit();

    });

    $('#sex_type_nasi_naka').change(function(){
        if ($(this).is(':checked')) {
            $('.sex_type_label').css({
                'background-color': '#FFF',
            });
            $('.sex_type_check ').css({
                'background-color': '#FC7BA2',
                'color': '#FFF'
            });
            $('.sex_type_check i').css({
                'color': '#FFF'
            });
            $('.sex_type_nasi_naka').css({
                'background-color': '#FC7BA2'
            });
        } else {
            $('.sex_type_nasi_naka').css({
                'background-color': '#FFF',
            });
        }
        $('#today_data').submit();

    });


    $('#sex_check').change(function(){
        if ($(this).is(':checked')) {
            $('.sex_type_label').css({
                'background-color': '#FFF',
            });
            $('.sex_type_check ').css({
                'background-color': '#FC7BA2',
                'color': '#FFF'
            });
            $('.sex_type_check i').css({
                'color': '#FFF'
            });

        } else {
            $('.sex_type_check ').css({
                'color': '#242A42'
            });
            $('.sex_type_check i').css({
                'color': '#FA7DA2'
            });
        }
        $('#today_data').submit();

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

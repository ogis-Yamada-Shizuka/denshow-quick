# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('input#vendor_id').blur ->
    $.post '/vendors/get_name', {code: $(@).val()}, (vendor_name) ->
     $('#vendor_name').text(vendor_name)

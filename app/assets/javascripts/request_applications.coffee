# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $(".select-model").select2({
    theme: "bootstrap"
  })

  $('.check-all-button').click ->
    if $(this).hasClass('clicked')
      $('.checkbox').prop('checked', false)
      $(this).removeClass('clicked')
    else
      $('.checkbox').prop('checked', true)
      $(this).addClass('clicked')

  $(".datetimepicker").datetimepicker(
    format: 'YYYY/MM/DD'
  )

  $('#file').change ->
    $('#file_name').val($(this).prop('files')[0].name)

$(document).on 'turbolinks:load', ->
  $(".select-doc-type").select2({
    theme: "bootstrap"
  })

  $(".select-chg-type").select2({
    theme: "bootstrap"
  })

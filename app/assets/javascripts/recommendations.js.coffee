jQuery ->
  $('.js-skip').on 'click', ->
    $(this).closest('.js-recommendation').hide()

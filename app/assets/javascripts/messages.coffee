$ ->
  $(document).on 'turbolinks:load', ->
    p = $('.message-p')
    bottom = p.offset().top + p.height()
    height = $(window).height()
    if bottom > height
      $(document).scrollTop bottom - height
    return

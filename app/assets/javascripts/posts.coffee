# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.dropdown').children('a').click ->
    $this = $(this)
    if $this.hasClass('open')
      $this.removeClass('open').next('ul').hide()
    else
      $this.addClass('open').next('ul').show()
    return
  return

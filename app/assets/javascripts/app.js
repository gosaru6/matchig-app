
$(document).on('turbolinks:load', function() {
  $('.dropdown').children('a').click(function() {
    // debugger
    let $this = $(this)
    if ($this.hasClass('open')){
      $this.removeClass('open').next('ul').hide();
    } else {
      $this.addClass('open').next('ul').show();
    }
  });
});

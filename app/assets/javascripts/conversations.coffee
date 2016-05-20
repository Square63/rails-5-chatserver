# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
bind_slim_scroll = ->
  $('.slimscroll').slimScroll
    height: '400px'

  $('.slimscroll').scrollTop($('.slimscroll')[0].scrollHeight) if $('.slimscroll').length > 0

bind_slim_scroll_list_friends = ->
  $('.list-friends').slimScroll
    height: '600px'

hide_flash_messages_onclick = ->
  $('body').on 'click', '.flash-alert', ->
    $(this).animate({top: -$(this).outerHeight()}, 500);

$ ->
  bind_slim_scroll_list_friends()
  bind_slim_scroll()
  hide_flash_messages_onclick()

$(document).on 'turbolinks:load', (event) ->
  bind_slim_scroll_list_friends()
  bind_slim_scroll()

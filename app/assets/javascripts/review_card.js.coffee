view_flash_message = (data) ->
  flash_container = $('<div>',
    {
      class: "alert alert-#{ data.message[0][0] }"
    })
  flash_message = $('<p>', {
    id: 'flash_message'
    text: data.message[0][1]
    }).appendTo(flash_container)
  $("#flash").html(flash_container)

class Timer
  constructor: ->
    @reset()
  reset: ->
    @time = new Date().getTime()
  get_time_left: ->
    new Date().getTime() - @time

get_new_card = ->
  $.ajax
    type: 'get'
    url: '/dashboard/review'
    dataType: 'json'
    success: (json) ->
      console.log json
      if json.message?
        $("#card_panel").empty()
        view_flash_message(json)
      else
        $('#card_img').html($("<img>", {src: json.image_url}))
        $('#translated_text').text(json.translated_text)
        $("#user_input").val("")
        $("#card_id").val(json.id)

ready = ->
  timer = new Timer
  $('#review_form').on 'submit', (e) ->
    e.preventDefault()
    url = $(this).attr('action')
    console.log url
    data =
      user_input: $(this).find("#user_input").val()
      card_id: $(this).find("#card_id").val()
      time_to_answer: timer.get_time_left()
    $.ajax
      type: 'put'
      url: url
      data: data
      dataType: 'json'
      success: (json) ->
        view_flash_message(json)
        do get_new_card
        do timer.reset

$(document).ready(ready)
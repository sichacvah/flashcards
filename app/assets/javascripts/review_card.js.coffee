ready = ->
  start_timer = new Date().getTime()
  $('form').on 'submit', ->
    time_now = new Date().getTime()
    input = $('<input>')
              .attr("type","hidden")
              .attr("name", "time_to_answer")
              .val(time_now - start_timer)
    $(this).append($(input))

$(document).ready(ready)
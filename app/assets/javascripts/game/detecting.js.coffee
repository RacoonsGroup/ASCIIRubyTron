$ ->
  $(document).keydown (e) ->
    if e.keyCode is 37
      $.post 'make_move',
        data: {direction: 'left'}
      false
    if e.keyCode is 38
      $.post 'make_move',
        data: {direction: 'up'}
      false
    if e.keyCode is 39
      $.post 'make_move',
        data: {direction: 'right'}
      false
    if e.keyCode is 40
      $.post 'make_move',
        data: {direction: 'down'}
      false

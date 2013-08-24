$ ->
  $(document).keydown (e) ->
    if e.keyCode is 37
      $.post 'make_move',
        data: {direction: [-1, 0]}
      false
    if e.keyCode is 38
      $.post 'make_move',
        data: {direction: [0, -1]}
      false
    if e.keyCode is 39
      $.post 'make_move',
        data: {direction: [1, 0]}
      false
    if e.keyCode is 40
      $.post 'make_move',
        data: {direction: [0, 1]}
      false

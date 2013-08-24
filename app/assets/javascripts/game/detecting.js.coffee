$ ->
  $(document).keydown (e) ->
    if $.cookie('player_number')? && $.cookie('player_number') != ''
      if e.keyCode is 37
        $.post 'make_move',
          direction: [-1, 0]
        false
      if e.keyCode is 38
        $.post 'make_move',
          direction: [0, -1]
        false
      if e.keyCode is 39
        $.post 'make_move',
          direction: [1, 0]
        false
      if e.keyCode is 40
        $.post 'make_move',
          direction: [0, 1]
        false

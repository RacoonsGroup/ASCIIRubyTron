$ ->
  PrivatePub.subscribe "/move", (data, channel) ->
    $("td#x" + data.coordinates[0] + "y" + data.coordinates[1]).text data.player

  PrivatePub.subscribe "/destroy", (data, channel) ->
    for coordinate in data.segments
      do (coordinate) ->
        $("td#x" + coordinate[0] + "y" + coordinate[1]).text ''

  PrivatePub.subscribe "/game_over", (data, channel) ->
    if $.cookie('player_number') == data.player
      alert('you loose')
    else
      alert('player ' + data.player + ' failed');

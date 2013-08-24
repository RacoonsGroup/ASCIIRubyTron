$ ->
  PrivatePub.subscribe "/move", (data, channel) ->
    $("td#x" + data.coordinates[0] + "y" + data.coordinates[1]).text data.player

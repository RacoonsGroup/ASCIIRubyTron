class Snake

  attr_reader :id
  attr_reader :snake_segments

  $SNAKE_COLORS = ['#FFA812', '#00FF00', '#007DFF', '#993366', '#F984E5', '#FF9900', '#000080', '#00FF7F', '#BADBAD']

  def initialize(id)
    @id = id
    @snake_segments = $redis.lrange("snake_#{id}", 0, -1)
  end

  def start!
    check_the_past
  end

  def move!(direction)
    if can_move?(direction)
      step(direction)
    else
      loose!
    end
  end

  def destroy!
    coordinates_for_destroy = @snake_segments.map {|e| e.split(',').map(&:to_i) }
    PrivatePub.publish_to "/destroy", segments: @snake_segments.map {|e| e.split(',').map(&:to_i) }
    $redis.del("snake_#{id}")
  end

  def loose!
    PrivatePub.publish_to "/game_over", player: @id
    destroy!
  end

private

  def check_the_past
    unless @id.present?
      previous_player_id = $redis.lindex('users', 0).to_i
      @id = previous_player_id + 1
      $redis.lpush "users", @id
      $redis.lpush "snake_#{@id}", ["0,#{@id * 3}"]
    end
  end


  def head_coordinates
    @snake_segments[0].split(',').map(&:to_i)
  end

  def can_move?(direction)
    new_head_coordinates = head_coordinates
    new_head_coordinates[0] += direction[0]
    new_head_coordinates[1] += direction[1]

    not_wall?(new_head_coordinates) && not_body?(new_head_coordinates)
  end

  def not_wall?(new_head_coordinates)
    new_head_coordinates.all?{|e| e >= 0 && e <= 99 }
  end

  def not_body?(new_head_coordinates)
    @snake_segments.all?{|e| e != "#{new_head_coordinates[0]},#{new_head_coordinates[1]}"}
  end

  def step(direction)
    new_head_coordinates = head_coordinates
    new_head_coordinates[0] += direction[0]
    new_head_coordinates[1] += direction[1]

    $redis.lpush "snake_#{@id}", "#{new_head_coordinates[0]},#{new_head_coordinates[1]}"

    PrivatePub.publish_to "/move",
      coordinates: new_head_coordinates,
      player: @id,
      color: $SNAKE_COLORS[@id]
  end
end

class Snake

  attr_reader :id
  attr_reader :snake_segments

  def initialize(id)
    @id = id
    @snake_segments = $redis.lrange("snake_#{id}", 0, -1)
    check_the_past
  end


  def move!(direction)
    step(direction) if can_move?(direction)
  end

private

  def check_the_past
    unless @id.present?
      previous_player_id = $redis.lindex('users', 0).to_i
      @id = previous_player_id + 1
      $redis.lpush "users", @id
      $redis.lpush "snake_#{@id}", ["0,#{@id}"]
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
    new_head_coordinates.all?{|e| e >= 0 && e <= 39 }
  end

  def not_body?(new_head_coordinates)
    @snake_segments.all?{|e| e != "#{new_head_coordinates[0]},#{new_head_coordinates[1]}"}
  end

  def step(direction)
    new_head_coordinates = head_coordinates
    new_head_coordinates[0] += direction[0]
    new_head_coordinates[1] += direction[1]

    $redis.lpush "snake_#{@id}", "#{new_head_coordinates[0]},#{new_head_coordinates[1]}"
    new_head_coordinates
  end
end

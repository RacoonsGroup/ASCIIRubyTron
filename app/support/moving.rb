module Moving
  class << self

    def move!(direction)
      step(direction) if can_move?(direction)
    end

  private

    def head_coordinates
      snake[0].split(',').map!(&:to_i)
    end

    def can_move?(direction)
      new_head_coordinates = head_coordinates
      new_head_coordinates[0] += direction[0]
      new_head_coordinates[1] += direction[1]

      not_wall?(new_head_coordinates) && not_body?(new_head_coordinates)
    end

    def not_wall?
      new_head_coordinates.all?{|e| e < 0 && e > 39 }
    end

    def not_body?
      snake.all?{|e| e != "#{new_head_coordinates[0]},#{new_head_coordinates[1]}"}
    end

    def snake(id = 'snake')
      $redis.get(id)
    end

    def step(direction, id = 'snake')
      new_head_coordinates = head_coordinates
      new_head_coordinates[0] += direction[0]
      new_head_coordinates[1] += direction[1]

      $redis.lpush 'id', "#{new_head_coordinates[0]},#{new_head_coordinates[1]}"
    end
  end
end

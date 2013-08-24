module Moving

  def get_head_coordinates
    snake[0].split(',')
    # snake = $redis.lindex('snake', 0).split(',')
  end

  def move!(direction)
    
    head=get_head_coordinates.map!(&:to_i)
    head[0] += direction[0]
    head[1] += direction[1]

    check_obstacle(head)

  end

  private

    def check_obstacle(coordinate)
      if coordinate < 0 or 
        
      end
    end

    def snake(id = 'snake')
      $redis.get(id)
    end

    def step(coordinate, id = 'snake')
      $redis.lpush 'id', coordinate
    end
end
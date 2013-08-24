module Moving
  class << self

    def get_head_coordinates
      snake[0].split(',')
      # snake = $redis.lindex('snake', 0).split(',')
    end

    def move!(direction)
      
      head=get_head_coordinates.map!(&:to_i)
      head[0] += direction[0]
      head[1] += direction[1]

      unless check_obstacle(head)
        step(head)
      else
        #game_end
      end
    end

    private

      def check_obstacle(coordinate)
        condition1 = false 
        coordinate.map{|e| condition1 = (e < 0) || condition1}
        condition2 = false
        coordinate.map{|e| condition2 = (e > 39) || condition2} 
        condition3 = false
        snake.map{|o| condition3 = (o == "{coordinate[0]},#{coordinate[1]}") || condition3}
        condition1 || condition2 || condition3        
      end

      def snake(id = 'snake')
        $redis.get(id)
      end

      def step(coordinate, id = 'snake')
        $redis.lpush 'id', "{coordinate[0]},#{coordinate[1]}"
      end
end

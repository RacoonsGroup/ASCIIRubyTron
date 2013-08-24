module ShowBefore
  class << self

    def all(user)
      user = snake(user)
    end

    private
      def snake(id = nil)
        $redis.lrange("snake_#{id}", 0, -1)
      end
  end
end

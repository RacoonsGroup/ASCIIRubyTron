module ShowBefore
  class << self

    def all(user)
      user = snake(user)
    end

    private
      def snake(id = 'snake')
        $redis.lrange(id, 0, -1)
      end
  end
end

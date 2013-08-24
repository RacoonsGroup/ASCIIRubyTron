class BattlefieldController < ApplicationController
  before_filter :get_ready_snake!

  def index
    users = $redis.lrange('users', 0, -1)
    @before = []
    users.each {|u| @before += ShowBefore.all(u)}
  end

  def make_move
    PrivatePub.publish_to "/move",
      coordinates: coordinates(params[:direction].map(&:to_i)),
      player: current_player
    render nothing: true
  end

  private

    def coordinates(direction)
      @snake.move!(direction)
    end

    def get_ready_snake!
      @snake = Snake.new(cookies[:player_number])
      cookies[:player_number] = @snake.id
    end

    def current_player
      cookies[:player_number]
    end
end

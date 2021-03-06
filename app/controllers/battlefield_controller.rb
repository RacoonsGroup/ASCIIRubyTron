class BattlefieldController < ApplicationController
  before_filter :get_ready_snake!

  def index
    users = $redis.lrange('users', 0, -1)
    @before = []
    users.each {|u| @before += [ShowBefore.all(u)]}
    @current_player=current_player.to_i
  end

  def make_move
    @snake.move!(params[:direction].map(&:to_i))
    render nothing: true
  end

  def quit_game
    @snake.destroy!
    cookies[:player_number] = nil
    redirect_to root_path
  end

  def start_game
    @snake.start!
    cookies[:player_number] = @snake.id
    redirect_to root_path
  end

  private

    def get_ready_snake!
      @snake = Snake.new(cookies[:player_number])
    end

    def current_player
      cookies[:player_number]
    end
end

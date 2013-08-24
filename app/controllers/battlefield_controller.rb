class BattlefieldController < ApplicationController

  def index
    users = $redis.lrange('users', 0, -1)
    @before = []
    users.each {|u| @before += ShowBefore.all(u)}

  end

  def make_move
    PrivatePub.publish_to "/move", coordinates: coordinates(params[:direction].map(&:to_i))
    render nothing: true
  end

  private

    def coordinates(direction)
      Moving.move!(direction)
    end
end
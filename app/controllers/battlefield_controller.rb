class BattlefieldController < ApplicationController

  def index
    $redis.lpush 'snake', ['0,0']
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
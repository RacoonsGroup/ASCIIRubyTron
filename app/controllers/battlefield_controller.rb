class BattlefieldController < ApplicationController

  def index

  end

  def make_move
    PrivatePub.publish_to "/move", coordinates: coordinates(params[:direction])
    render nothing: true
  end

  private

    def coordinates(direction)
      Moving.move!(direction)
    end
end
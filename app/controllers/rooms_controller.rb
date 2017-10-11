class RoomsController < ApplicationController
  def index
    @rooms = Room.all.preload(:shifts)
  end
end

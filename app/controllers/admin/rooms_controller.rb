class Admin::RoomsController < AdminController
  def index
    @rooms = Room.all.preload(:shifts)
  end
end

class UsersController < ApplicationController
  def show
    @user = if current_user.admin?
            User.includes(:offsprings).references(:offsprings).find_by(id: params[:id])
            else
            User.includes(:offsprings).references(:offsprings).find_by(id: current_user.id)
            end
    if @user.nil?
      flash[:alert] = t '.user_not_found'
      redirect_to user_offsprings_path
    end
    @offsprings = @user.offsprings.includes(:assignment)
  end
end

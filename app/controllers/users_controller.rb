class UsersController < ApplicationController
  def show
    @user = if current_user.admin?
            User.find_by(id: params[:id])
            else
            User.find_by(id: current_user.id)
            end
    if @user.nil?
      flash[:alert] = t '.user_not_found'
      redirect_to user_path
    end
  end
end

class AdminController < ApplicationController
  before_action :user_is_admin?


  protected

  def user_is_admin?
    redirect_to root_path unless current_user&.admin?
  end
end
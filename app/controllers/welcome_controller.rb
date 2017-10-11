class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    render :file => 'public/index.html'
  end
end

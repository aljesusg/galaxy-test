class OffspringsController < ApplicationController
  ALLOWED_GRADES = ['primary_first'].freeze

  def new
    @offspring = Offspring.new(user: current_user)
  end

  def index
    @offsprings = Offspring.includes(:assignment).where(user: current_user)
  end

  def create
    unless ALLOWED_GRADES.include? offsprings_params[:grade]
      flash[:danger] = t '.invalid_grade'
      redirect_to offsprings_path
      return
    end
    @offspring = Offspring.new(offsprings_params)
    @offspring.user = current_user
    if @offspring.save
      flash[:success] = t('.offspring_added', offspring: @offspring.first_name)
      redirect_to user_path(current_user)
    else
      flash[:alert] = t '.offspring_not_added'
      render :new
    end
  end

  def edit
    @offspring = Offspring.find_by(id: params[:id], user: current_user)
    if @offspring.nil?
      flash[:alert] = t '.offspring_not_found'
      redirect_to offsprings_path
    end
  end

  def show
    if current_user.admin?
      @offspring = Offspring.find_by(id: params[:id])
    else
      @offspring = Offspring.find_by(user: current_user, id: params[:id])
    end

    @assignment = Assignment.find_by(offspring: @offspring)
    if @offspring.nil?
      flash[:alert] = t('.offspring_not_found')
      redirect_to user_path(current_user)
    end
  end

  def update
    @offspring = Offspring.find_by(id: params[:id], user: current_user)
    if @offspring.nil?
      flash[:alert] = t '.offspring_not_found'
      redirect_to offsprings_path
    elsif @offspring.update_attributes(offsprings_params)
      flash[:success] = t('.offspring_updated', name: @offspring.full_name)
      redirect_to offspring_path(@offspring)
    else
      flash[:alert] = t '.offspring_not_updated'
      render :edit
    end
  end

  def destroy
    @offspring = Offspring.find_by(id: params["id"], user: current_user)
    if @offspring.nil?
      flash[:alert] = t '.offspring_not_found'
    elsif @offspring.destroy
      flash[:success] = (t ".offspring_deleted", offspring: @offspring.first_name)
    else
      flash[:alert] = (t ".offspring_not_deleted")
    end
    redirect_to offsprings_path
  end

  private

  def offsprings_params
    params.require(:offspring).permit(:first_name, :last_name, :grade)
  end
end

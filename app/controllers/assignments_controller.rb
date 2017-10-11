class AssignmentsController < ApplicationController
  def new
    unless(@offspring = Offspring.includes(:user).find_by(id: params[:offspring_id], user_id: current_user.id))
      flash[:alert] = t '.offspring_not_found'
      redirect_to offsprings_path
    end
    @rooms = Room.all.includes(:shifts)
    @shifts = Shift.all
  end

  def create
    Assignment.transaction do
      @assignment = Assignment.find_by(offspring: params[:offspring_id]) || Assignment.new
      @assignment.shift = Shift.find_by(id: params[:shift_id])
      @assignment.offspring = Offspring.find_by(id: params[:offspring_id], user: current_user)

      if @assignment.offspring.nil?
        flash[:alert] = (t '.assignment_not_added')
        redirect_to offsprings_path
      elsif @assignment.save
        AssignmentsMailer.shift_assigned_email(current_user, @assignment.offspring, @assignment).deliver_later
        flash[:success] = (t '.assignment_added')
        redirect_to offsprings_path
      else
        flash[:alert] = (t '.assignment_not_added')
        render 'new'
      end
    end
  end
end

class Admin::ShiftsController < AdminController

  def show
    @shift = Shift.find_by(id: params[:id])
    @offsprings = Offspring.includes(:assignment).where('assignments.shift_id': @shift)

    if @shift.nil?
      flash[:alert] = t('.shift_not_found')
      redirect_to admin_rooms_path
    end


    respond_to do |format|
      format.html
      format.csv { send_data @offsprings.to_csv, filename: "shift-#{@shift.full_name}-#{Date.today}.csv" }
    end
  end
end

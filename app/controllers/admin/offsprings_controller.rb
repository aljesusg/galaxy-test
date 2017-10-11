class Admin::OffspringsController < AdminController

  def index
    @offsprings = Offspring.all

    respond_to do |format|
      format.html
      format.csv { send_data @offsprings.to_csv, filename: "offsprings-#{Date.today}.csv" }
    end
  end
end

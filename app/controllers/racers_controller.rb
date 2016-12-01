class RacersController < ApplicationController

  # Show all racers
  def index
    @racers = Racer.all
    if params[:search]
      @racers = Racer.search(params[:search])
    end
  end

  # Convert raw time to seconds to use in ChartKick
  def to_seconds(raw_time)
    time_split = raw_time.split(":")
    hours = time_split[0]
    minutes = time_split[1]
    seconds = time_split[2]
    return hours.to_i * 3600 + minutes.to_i * 60 + seconds.to_i
  end

  # Show racer by id
  def show
    @racer = Racer.find(params[:id])
    longest_streak, current_streak = update_streak_calendar([@racer.id])
    @longest_streak_for_view = "(" + longest_streak[0].to_s + " through " + longest_streak[-1].to_s + ")"
    if current_streak.length == 0
      @current_streak_for_view = "(no current streak)"
    else
      @current_streak_for_view = "(" + current_streak[0].to_s + " through " + current_streak[-1].to_s + ")"
    end
    @results_to_show = @racer.results.joins(:race).where(group_name: "ALL").map {|result| [Race.find(result.race_id).date, to_seconds(result.time)] }
    if current_user
    @user_order = Order.where(:user_id => current_user.id).first
    end
  end

  # Delete racer
  def destroy
    @racer = Racer.find(params[:id])
    @racer.destroy
  end

  # Edit racer
  def edit
    @racer = Racer.find(params[:id])
  end

  # claim this racer
  def claim_this_racer
    racer = Racer.find(params[:id])
    racer = Racer.find(params[:id])
  end

  # Create article
  def create
  	@racer = Racer.new(racer_params)
    if @racer.save
      redirect_to @racer
    else
      render 'new'
    end
  end

  # New racer
  def new
  	@racer = Racer.new
  end

  # Update racer
  def update
    @racer = Racer.find(params[:id])
    if @racer.update(racer_params)
      redirect_to @racer
    else
      render 'edit'
    end
  end

  # import CSV
  def import
    Racer.import(params[:file])
    redirect_to racers_url, notice: "Racers imported successfully"
  end

  # Permit parameters when creating article
  private
  def racer_params
    params.require(:racer).permit(:first_name, :last_name)
  end
end
class WorkoutsController < ApplicationController

  before_action :set_workout, only: [:show, :edit, :update, :destroy]

  # GET /workouts
  # workouts_path
  def index
    @workouts = WorkoutPresenter.wrap(finder.most_recents)
  end

  # GET /workouts/:id
  # workout_path(:id)
  def show
  end

  # GET /workouts/new
  # new_workout_path
  def new
    @workout = Workout.new_with_defaults(current_user)
  end

  # POST /workouts
  # workouts_path
  # TODO spec
  def create
    @workout = current_user.workouts.build(workout_params)
    if @workout.save
      redirect_to workout_path(@workout),
        notice: t('.success')
    else
      render :new
    end
  end

  # GET /workouts/:id/edit
  # edit_workout_path(:id)
  # TODO spec
  def edit
  end

  # PUT /workouts/:id
  # PATCH /workouts/:id
  # workout_path(:id)
  # TODO spec
  def update
    if @workout.update(workout_params)
      redirect_to workout_path(@workout),
        notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /workouts/:id
  # workout_path(:id)
  # TODO spec
  def destroy
    @workout.destroy
    redirect_to workouts_path,
      notice: t('.success')
  end

  private

  def finder
    @finder ||= WorkoutFinderService.new(current_user)
  end

  def set_workout
    @workout = WorkoutPresenter.new(finder.find(params[:id]))
  end

  def workout_params
    params.require(:workout).
      permit(:kind, :scheduled_on, :occurred_on, :name, :description,
        :observations, :coach_observations, :weight_before, :weight_after,
        :distance, :elapsed_time_in_hours, :moving_time_in_hours, :speed_avg,
        :speed_max, :cadence_avg, :cadence_max, :calories, :elevation_gain,
        :temperature_avg, :temperature_max, :temperature_min, :watts_avg,
        :watts_weighted_avg, :watts_max, :heart_rate_avg, :heart_rate_max).
      delocalize(weight_before: :number, weight_after: :number,
        distance: :number, speed_avg: :number, speed_max: :number,
        cadence_avg: :number, cadence_max: :number, calories: :number,
        elevation_gain: :number, temperature_avg: :number,
        temperature_min: :number, temperature_max: :number, watts_avg: :number,
        watts_weighted_avg: :number, watts_max: :number,
        heart_rate_avg: :number, heart_rate_max: :number,
        scheduled_on: :date, occurred_on: :date)
  end

end

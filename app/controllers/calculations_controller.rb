class CalculationsController < ApplicationController
  before_action :set_calculation, only: [:show, :edit, :update, :destroy, :save]

  def index
    @calculations = current_user.calculations.where(saved: true).order(reference_month: :desc)
    @query = params[:q]
    if @query.present?
      @calculations = @calculations.where("to_char(reference_month, 'MM/YYYY') ILIKE ?", "%#{@query}%")
    end
  end

  def show
  end

  def new
    @calculation = current_user.calculations.build
    @step = 1
  end

  def create
    @calculation = current_user.calculations.build(reference_month: calculation_reference_month)

    if @calculation.save
      build_activities(@calculation)
      @calculation.compute_total!
      redirect_to @calculation, notice: "Cálculo salvo com sucesso!"
    else
      @step = 1
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @step = params[:step]&.to_i || 1
  end

  def update
    build_activities(@calculation)
    @calculation.compute_total!
    redirect_to @calculation, notice: "Cálculo atualizado!"
  end

  def destroy
    @calculation.destroy
    redirect_to calculations_path, notice: "Cálculo removido."
  end

  def save
    @calculation.update!(saved: true)
    redirect_to @calculation, notice: "Cálculo salvo no histórico!"
  end

  private

  def set_calculation
    @calculation = current_user.calculations.find(params[:id])
  end

  def calculation_reference_month
    year  = params.dig(:calculation, :year)&.to_i  || Date.today.year
    month = params.dig(:calculation, :month)&.to_i || Date.today.month
    Date.new(year, month, 1)
  rescue ArgumentError
    Date.today.beginning_of_month
  end

  def build_activities(calc)
    tp = params[:transport] || {}
    ep = params[:energy]    || {}
    fp = params[:food]      || {}
    sp = params[:shopping]  || {}

    upsert_activity(calc, TransportActivity, {
      car_km: tp[:car_km].to_f,
      bus_km: tp[:bus_km].to_f,
      flights_per_year: tp[:flights_per_year].to_f
    })

    upsert_activity(calc, EnergyActivity, {
      kwh_consumption: ep[:kwh_consumption].to_f,
      energy_source: ep[:energy_source].presence || "eletricidade"
    })

    upsert_activity(calc, FoodActivity, {
      diet_type: fp[:diet_type].presence || "onivoro",
      meat_kg: fp[:meat_kg].to_f
    })

    upsert_activity(calc, ShoppingActivity, {
      monthly_spend: sp[:monthly_spend].to_f,
      shopping_category: sp[:shopping_category].presence || "outros"
    })
  end

  def upsert_activity(calc, klass, attrs)
    activity = klass.find_or_initialize_by(calculation: calc)
    activity.assign_attributes(attrs)
    activity.save!
    activity.calculate_emission!
  end
end

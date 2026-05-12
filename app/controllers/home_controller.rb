class HomeController < ApplicationController
  def index
    @last_calculation = current_user.calculations.where(saved: true).order(reference_month: :desc).first
    @recent_calculations = current_user.calculations.where(saved: true).order(reference_month: :desc).limit(3)
  end
end

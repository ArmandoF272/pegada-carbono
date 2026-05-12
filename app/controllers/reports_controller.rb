class ReportsController < ApplicationController
  def show
    @last = current_user.calculations.where(saved: true).order(reference_month: :desc).first
    @history = current_user.calculations.where(saved: true).order(reference_month: :desc).limit(6).reverse
  end
end

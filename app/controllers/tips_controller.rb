class TipsController < ApplicationController
  def index
    @tips = Tip.by_impact
    @category = params[:category]
    @tips = @tips.by_category(@category) if @category.present? && Tip::CATEGORIES.include?(@category)
  end
end

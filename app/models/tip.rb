class Tip < ApplicationRecord
  CATEGORIES = %w[Transporte Energia Alimentação Compras].freeze
  DIFFICULTIES = %w[Fácil Médio Difícil].freeze

  validates :category, inclusion: { in: CATEGORIES }
  validates :difficulty, inclusion: { in: DIFFICULTIES }
  validates :text, :impact_tco2_year, presence: true

  scope :by_category, ->(cat) { where(category: cat) }
  scope :by_impact, -> { order(impact_tco2_year: :desc) }
end

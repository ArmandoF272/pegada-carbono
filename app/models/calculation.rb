class Calculation < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_one :transport_activity, class_name: "TransportActivity", dependent: :destroy
  has_one :energy_activity, class_name: "EnergyActivity", dependent: :destroy
  has_one :food_activity, class_name: "FoodActivity", dependent: :destroy
  has_one :shopping_activity, class_name: "ShoppingActivity", dependent: :destroy

  validates :reference_month, presence: true
  validates :reference_month, uniqueness: { scope: :user_id, message: "já existe um cálculo para este mês" }

  BRAZIL_AVERAGE = 6.50
  PARIS_GOAL = 2.30

  def compute_total!
    total = activities.sum(&:emission_kg).to_f / 1000.0
    update!(total_emission: total.round(2))
  end

  def emission_by_category
    {
      "Transporte"  => (transport_activity&.emission_kg.to_f / 1000.0).round(2),
      "Energia"     => (energy_activity&.emission_kg.to_f / 1000.0).round(2),
      "Alimentação" => (food_activity&.emission_kg.to_f / 1000.0).round(2),
      "Compras"     => (shopping_activity&.emission_kg.to_f / 1000.0).round(2)
    }
  end

  MESES_PT = %w[Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro].freeze

  def formatted_month
    "#{MESES_PT[reference_month.month - 1]} · #{reference_month.year}"
  end

  def variation_from_previous
    previous = user.calculations
                   .where(saved: true)
                   .where("reference_month < ?", reference_month)
                   .order(reference_month: :desc)
                   .first
    return nil unless previous&.total_emission
    (total_emission.to_f - previous.total_emission).round(2)
  end
end

class FoodActivity < Activity
  # kgCO2e por kg de carne bovina (média IPCC)
  BEEF_FACTOR = 27.0

  DIET_BASE = {
    "onivoro"     => 150.0,  # kgCO2e/mês (base sem carne adicional)
    "vegetariano" => 60.0,
    "vegano"      => 30.0
  }.freeze

  def calculate_emission!
    base  = DIET_BASE.fetch(diet_type.to_s, 150.0)
    extra = meat_kg.to_f * BEEF_FACTOR
    update!(emission_kg: (base + extra).round(2))
  end
end

class ShoppingActivity < Activity
  # kgCO2e por R$ gasto por categoria (estimativas adaptadas SEEG)
  CATEGORY_FACTORS = {
    "eletronicos"  => 0.50,
    "roupas"       => 0.30,
    "alimentos"    => 0.15,
    "servicos"     => 0.10,
    "outros"       => 0.20
  }.freeze

  def calculate_emission!
    factor = CATEGORY_FACTORS.fetch(shopping_category.to_s, 0.20)
    update!(emission_kg: (monthly_spend.to_f * factor).round(2))
  end
end

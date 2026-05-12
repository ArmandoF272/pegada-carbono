class EnergyActivity < Activity
  # Mix de energia elétrica Brasil (SEEG 2023): ~0,10 kgCO2/kWh
  ELECTRICITY_FACTORS = {
    "eletricidade" => 0.10,
    "gas_natural"  => 2.04,  # kgCO2/m3
    "solar"        => 0.02
  }.freeze

  def calculate_emission!
    kwh    = kwh_consumption.to_f
    factor = ELECTRICITY_FACTORS.fetch(energy_source.to_s, 0.10)
    update!(emission_kg: (kwh * factor).round(2))
  end
end

class TransportActivity < Activity
  # Fatores SEEG/IPCC contextualizados para o Brasil
  CAR_FACTOR      = 0.21   # kgCO2/km (gasolina)
  BUS_FACTOR      = 0.089  # kgCO2/km
  FLIGHT_FACTOR   = 255.0  # kgCO2/trecho doméstico

  def calculate_emission!
    km_car   = car_km.to_f
    km_bus   = bus_km.to_f
    flights  = flights_per_year.to_f

    total = (km_car * CAR_FACTOR) + (km_bus * BUS_FACTOR) + ((flights * FLIGHT_FACTOR) / 12.0)
    update!(emission_kg: total.round(2))
  end
end

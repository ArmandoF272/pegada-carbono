require "rails_helper"

RSpec.describe Calculation, type: :model do
  let(:user) { User.create!(name: "Teste", email: "teste@example.com", password: "senha123") }

  describe "cálculo de emissões" do
    it "calcula corretamente a emissão de transporte (100 km de carro)" do
      calc = user.calculations.create!(reference_month: Date.today.beginning_of_month, saved: false)
      transport = TransportActivity.create!(calculation: calc, car_km: 100, bus_km: 0, flights_per_year: 0)
      transport.calculate_emission!

      expect(transport.emission_kg).to be_within(0.1).of(21.0)
    end

    it "calcula corretamente a emissão de energia (200 kWh elétrico)" do
      calc = user.calculations.create!(reference_month: Date.today.beginning_of_month, saved: false)
      energy = EnergyActivity.create!(calculation: calc, kwh_consumption: 200, energy_source: "eletricidade")
      energy.calculate_emission!

      expect(energy.emission_kg).to be_within(0.1).of(20.0)
    end

    it "converte kg para toneladas no total anual" do
      calc = user.calculations.create!(reference_month: Date.today.beginning_of_month, saved: false)
      TransportActivity.create!(calculation: calc, car_km: 0, bus_km: 0, flights_per_year: 0).tap(&:calculate_emission!)
      EnergyActivity.create!(calculation: calc, kwh_consumption: 1000, energy_source: "eletricidade").tap(&:calculate_emission!)
      FoodActivity.create!(calculation: calc, diet_type: "onivoro", meat_kg: 0).tap(&:calculate_emission!)
      ShoppingActivity.create!(calculation: calc, monthly_spend: 0, shopping_category: "outros").tap(&:calculate_emission!)

      calc.compute_total!
      # 1000 kWh × 0.10 = 100 kg energia + 150 kg base onívoro = 250 kg = 0.25 t
      expect(calc.total_emission).to be_within(0.01).of(0.25)
    end
  end

  describe "validações" do
    it "não permite dois cálculos no mesmo mês para o mesmo usuário" do
      mes = Date.today.beginning_of_month
      user.calculations.create!(reference_month: mes, saved: false)
      duplicado = user.calculations.build(reference_month: mes)
      expect(duplicado).not_to be_valid
    end
  end
end

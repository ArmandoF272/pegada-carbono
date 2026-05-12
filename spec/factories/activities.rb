FactoryBot.define do
  factory :activity do
    calculation { nil }
    type { "" }
    emission_kg { 1.5 }
    car_km { 1.5 }
    bus_km { 1.5 }
    flights_per_year { 1.5 }
    kwh_consumption { 1.5 }
    energy_source { "MyString" }
    diet_type { "MyString" }
    meat_kg { 1.5 }
    monthly_spend { 1.5 }
    shopping_category { "MyString" }
  end
end

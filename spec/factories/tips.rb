FactoryBot.define do
  factory :tip do
    category { "MyString" }
    text { "MyText" }
    impact_tco2_year { 1.5 }
    difficulty { "MyString" }
  end
end

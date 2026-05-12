FactoryBot.define do
  factory :calculation do
    user { nil }
    reference_month { "2026-05-11" }
    total_emission { 1.5 }
    saved { false }
  end
end

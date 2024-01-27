FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Fantasy::Tolkien.poem }
    temperature { 208.05 }
    brew_time { "3 Minutes" }
  end
end

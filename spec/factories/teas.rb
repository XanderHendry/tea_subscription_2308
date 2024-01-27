FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Fantasy::Tolkien.poem }
    temperature { Faker::Number.number(digits: 3) }
    brew_time { "#{Faker::Number.between(from: 2, to: 8)} Minutes" }
    price { Faker::Commerce.price }
  end
end

FactoryBot.define do
  factory :subscription do
    association :customer
    association :tea
    title { self.tea.title }
    price { Faker::Commerce.price }
    status { [0,1].sample }
    frequency { "2x/Month" }
  end
end

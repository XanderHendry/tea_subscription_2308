FactoryBot.define do
  factory :subscription do
    association :customer
    association :tea
    title { tea.title }
    price { tea.price }
    status { [0,1].sample }
    frequency { Faker::Subscription.payment_term }
  end
end

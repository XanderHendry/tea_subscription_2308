class SubscriptionsSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency

  attribute :tea do |object|
    {
      title: object.tea.title,
      description: object.tea.description,
      temperature: object.tea.temperature,
      brew_time: object.tea.brew_time
    }
  end

  attribute :customer do |object|
    {
      first_name: object.customer.first_name,
      last_name: object.customer.last_name,
      email: object.customer.email,
      address: object.customer.address
    }
  end
end

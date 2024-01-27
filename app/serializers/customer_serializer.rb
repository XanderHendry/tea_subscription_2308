class CustomerSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :address

  attribute :subscriptions do |object|
    object.subscriptions.map do |sub|
      {
        id: sub.id.to_s,
        title: sub.title,
        price: sub.price,
        status: sub.status,
        frequency: sub.frequency
      }
    end
  end
end

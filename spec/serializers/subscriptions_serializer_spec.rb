require 'rails_helper'

RSpec.describe SubscriptionsSerializer do
  before(:each) do
    sub = create(:subscription)
    serialized_response = SubscriptionsSerializer.new(sub)
    @output = JSON.parse(serialized_response.to_json, symbolize_names: true)
    @attributes = @output[:data][:attributes]
  end
  it 'formats data for a Subscription object' do
    expect(@output).to have_key(:data)
    expect(@output[:data]).to be_a(Hash)
    expect(@output[:data]).to have_key(:id)
    expect(@output[:data][:id]).to be_a(String)
    expect(@output[:data]).to have_key(:type)
    expect(@output[:data][:type]).to eq("subscriptions")
    expect(@output[:data]).to have_key(:attributes)
    expect(@output[:data][:attributes]).to be_an(Hash)

    # Subscription Data
    expect(@attributes).to have_key(:title)
    expect(@attributes[:title]).to be_an(String)
    expect(@attributes).to have_key(:price)
    expect(@attributes[:price]).to be_an(Float)
    expect(@attributes).to have_key(:status)
    expect(@attributes[:status]).to be_an(String)
    expect(@attributes).to have_key(:frequency)
    expect(@attributes[:frequency]).to be_an(String)

    # Tea Data
    expect(@attributes).to have_key(:tea)
    expect(@attributes[:tea]).to be_an(Hash)
    expect(@attributes[:tea]).to have_key(:title)
    expect(@attributes[:tea][:title]).to be_an(String)
    expect(@attributes[:tea]).to have_key(:description)
    expect(@attributes[:tea][:description]).to be_an(String)
    expect(@attributes[:tea]).to have_key(:temperature)
    expect(@attributes[:tea][:temperature]).to be_an(Integer)
    expect(@attributes[:tea]).to have_key(:brew_time)
    expect(@attributes[:tea][:brew_time]).to be_an(String)

    # Customer Data
    expect(@attributes).to have_key(:customer)
    expect(@attributes[:customer]).to be_an(Hash)
    expect(@attributes[:customer]).to have_key(:first_name)
    expect(@attributes[:customer][:first_name]).to be_an(String)
    expect(@attributes[:customer]).to have_key(:last_name)
    expect(@attributes[:customer][:last_name]).to be_an(String)
    expect(@attributes[:customer]).to have_key(:email)
    expect(@attributes[:customer][:email]).to be_an(String)
    expect(@attributes[:customer]).to have_key(:address)
    expect(@attributes[:customer][:address]).to be_an(String)
  end
  it 'omits unwanted data' do
    expect(@attributes).to_not have_key(:customer_id)
    expect(@attributes).to_not have_key(:tea_id)
    expect(@attributes).to_not have_key(:created_at)
    expect(@attributes).to_not have_key(:updated_at)
    expect(@attributes[:tea]).to_not have_key(:id)
    expect(@attributes[:tea]).to_not have_key(:price)
    expect(@attributes[:tea]).to_not have_key(:created_at)
    expect(@attributes[:tea]).to_not have_key(:updated_at)
    expect(@attributes[:customer]).to_not have_key(:id)
    expect(@attributes[:customer]).to_not have_key(:created_at)
    expect(@attributes[:customer]).to_not have_key(:updated_at)
  end
end

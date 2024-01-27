require 'rails_helper'

RSpec.describe CustomerSerializer do
  before(:each) do
    customer = create(:customer)
    tea_1 = create(:tea)
    tea_2 = create(:tea)
    subscription_1 = create(:subscription, tea_id: tea_1.id, customer_id: customer.id, status: 0)
    subscription_2 = create(:subscription, tea_id: tea_2.id, customer_id: customer.id, status: 1)
    serialized_response = CustomerSerializer.new(customer)
    @output = JSON.parse(serialized_response.to_json, symbolize_names: true)
    @attributes = @output[:data][:attributes]
  end
  it 'formats data for a Subscription object' do
    expect(@output).to have_key(:data)
    expect(@output[:data]).to be_a(Hash)
    expect(@output[:data]).to have_key(:id)
    expect(@output[:data][:id]).to be_a(String)
    expect(@output[:data]).to have_key(:type)
    expect(@output[:data][:type]).to eq("customer")
    expect(@output[:data]).to have_key(:attributes)
    expect(@output[:data][:attributes]).to be_an(Hash)

    # Customer Data
    expect(@attributes).to be_an(Hash)
    expect(@attributes).to have_key(:first_name)
    expect(@attributes[:first_name]).to be_an(String)
    expect(@attributes).to have_key(:last_name)
    expect(@attributes[:last_name]).to be_an(String)
    expect(@attributes).to have_key(:email)
    expect(@attributes[:email]).to be_an(String)
    expect(@attributes).to have_key(:address)
    expect(@attributes[:address]).to be_an(String)

    # Subscription Data
    expect(@attributes).to have_key(:subscriptions)
    expect(@attributes[:subscriptions]).to be_an(Array)
    expect(@attributes[:subscriptions].count).to eq(2)
    @attributes[:subscriptions].each do |sub|
      expect(sub).to have_key(:id)
      expect(sub[:id]).to be_an(String)
      expect(sub).to have_key(:title)
      expect(sub).to have_key(:price)
      expect(sub).to have_key(:status)
      expect(sub[:status]).to be_an(String)
      expect(sub).to have_key(:frequency)
      expect(sub[:frequency]).to be_an(String)
    end
  end
  it 'omits unwanted data' do
    expect(@attributes).to_not have_key(:customer_id)
    expect(@attributes).to_not have_key(:tea)
    expect(@attributes).to_not have_key(:created_at)
    expect(@attributes).to_not have_key(:updated_at)
    @attributes[:subscriptions].each do |sub|
      expect(sub).to_not have_key(:created_at)
      expect(sub).to_not have_key(:updated_at)
      expect(sub).to_not have_key(:customer_id)
      expect(sub).to_not have_key(:tea_id)
    end
  end
end
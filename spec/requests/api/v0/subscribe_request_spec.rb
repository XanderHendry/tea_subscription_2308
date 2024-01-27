# An endpoint to subscribe a customer to a tea subscription
require 'rails_helper'

RSpec.describe 'Subscribe Customer to Tea Subscription (post /api/v0/subscribe)' do
  before(:each) do
   @customer = create(:customer)
   @tea = create(:tea)
  end
  describe 'Happy Path' do
    it 'Allows a customer to enroll in a tea subscription' do
      post '/api/v0/subscriptions', params: {
        customer_id: @customer.id,
        tea_id: @tea.id,
        frequency: "Monthly"
      }
      expect(response).to be_successful
      expect(response.status).to eq(201)
      result = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
      expect(result[:status]).to eq("Active")
      expect(result[:tea][:title]).to eq(@tea.title)
      expect(result[:customer][:first_name]).to eq(@customer.first_name)
    end
  end
end 

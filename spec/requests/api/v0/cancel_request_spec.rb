# An endpoint to cancel a customer’s tea subscription
require 'rails_helper'

RSpec.describe 'Cancel a Customers Tea Subscription (delete /api/v0/subscriptions/:id)' do
  before(:each) do
   @customer = create(:customer)
   @tea_1 = create(:tea)
   @tea_2 = create(:tea)
   @subscription_1 = create(:subscription, tea_id: @tea_1.id, customer_id: @customer.id)
   @subscription_2 = create(:subscription, tea_id: @tea_2.id, customer_id: @customer.id)
  end
  describe 'Happy Path' do
    it 'Allows a customer to cancel a tea subscription' do
      delete "/api/v0/subscriptions/#{@subscription_2.id}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
      expect(result[:status]).to eq("Cancelled")
      expect(result[:tea][:title]).to eq(@tea_2.title)
      expect(result[:customer][:first_name]).to eq(@customer.first_name)
    end
  end
  describe 'Sad Path' do
    it 'will return an error message if a bad subscription id is provided' do
      delete "/api/v0/subscriptions/bad_id"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      result = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(result[:title]).to eq("Couldn't find Subscription with 'id'=bad_id")
    end
  end
end 

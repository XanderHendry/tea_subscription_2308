# An endpoint to see all of a customer’s subsciptions (active and cancelled)
require 'rails_helper'

RSpec.describe 'List all of a Customers Tea Subscriptions (get /api/v0/subscriptions)' do
  before(:each) do
    @customer = create(:customer)
    @tea_1 = create(:tea)
    @tea_2 = create(:tea)
    @subscription_1 = create(:subscription, tea_id: @tea_1.id, customer_id: @customer.id, status: 0)
    @subscription_2 = create(:subscription, tea_id: @tea_2.id, customer_id: @customer.id, status: 1)
   end
  describe 'Happy Path' do
    it 'lists a customers active and cancelled tea subscriptions' do
      get '/api/v0/subscriptions', params: {
        customer_id: @customer.id
      }
      expect(response).to be_successful
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].count).to eq(2)
      sub_1 = result[:data].first[:attributes]
      expect(sub_1[:status]).to eq("Active")
      expect(sub_1[:tea][:title]).to eq(@tea_1.title)
      expect(sub_1[:customer][:first_name]).to eq(@customer.first_name)
      sub_2 = result[:data].last[:attributes]
      expect(sub_2[:status]).to eq("Cancelled")
      expect(sub_2[:tea][:title]).to eq(@tea_2.title)
      expect(sub_2[:customer][:first_name]).to eq(@customer.first_name)
    end
  end
end 

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
      get '/api/v0/customers', params: {
        customer_id: @customer.id
      }
      expect(response).to be_successful
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data]).to be_an(Hash)
      expect(result[:data][:attributes][:first_name]).to eq(@customer.first_name)
      expect(result[:data][:attributes][:subscriptions].count).to eq(2)
    end
  end
  describe 'Sad Path' do
    it 'will return an error message if an invalid Customer id is given' do
      get '/api/v0/customers', params: {
        customer_id: 'bad ID'
      }
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      result = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(result[:title]).to eq("Couldn't find Customer with 'id'=bad ID")
    end
  end
end 

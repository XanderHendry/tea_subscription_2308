# An endpoint to subscribe a customer to a tea subscription
require 'rails_helper'

RSpec.describe 'Subscribe Customer to Tea Subscription (post /api/v0/subscriptions)' do
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
  describe 'Sad Path' do
    it 'will return an error message if a field is left blank' do
      # No Customer ID
      post '/api/v0/subscriptions', params: {
        tea_id: @tea.id,
        frequency: "Monthly"
      }
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      result = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(result[:title]).to eq("Couldn't find Customer without an ID")
      # No Tea ID
      post '/api/v0/subscriptions', params: {
        customer_id: @customer.id,
        frequency: "Monthly"
      }
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      result = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(result[:title]).to eq("Couldn't find Tea without an ID")
      # No Frequency
      post '/api/v0/subscriptions', params: {
        customer_id: @customer.id,
        tea_id: @tea.id
      }
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(result[:title]).to eq("param is missing or the value is empty: frequency")
    end
    it 'will return an error message if an invalid customer_id or tea_id is given' do
      # Bad Customer ID
      post '/api/v0/subscriptions', params: {
        customer_id: "bad ID",
        tea_id: @tea.id,
        frequency: "Monthly"
      }
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      result = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(result[:title]).to eq("Couldn't find Customer with 'id'=bad ID")
      # Bad Tea ID
      post '/api/v0/subscriptions', params: {
        customer_id: @customer.id,
        tea_id: "bad ID",
        frequency: "Monthly"
      }
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      result = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(result[:title]).to eq("Couldn't find Tea with 'id'=bad ID")
    end

    it 'will return an error message if a subscription already exists' do
      post '/api/v0/subscriptions', params: {
        customer_id: @customer.id,
        tea_id: @tea.id,
        frequency: "Monthly"
      }
      expect(response).to be_successful
      expect(response.status).to eq(201)

      post '/api/v0/subscriptions', params: {
        customer_id: @customer.id,
        tea_id: @tea.id,
        frequency: "Monthly"
      }
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      result = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(result[:title]).to eq("Customer is already enrolled in this Tea Subscription!")
    end
  end
end 

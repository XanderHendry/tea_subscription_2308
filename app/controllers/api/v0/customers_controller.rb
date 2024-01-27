module Api
  module V0
    class CustomersController < ApplicationController
      def index
        customer = Customer.find(params[:customer_id])
        render json: CustomerSerializer.new(customer), status: :ok
      end

      private

      def customer_params
        params.require(:customer_id)
        params.permit(:customer_id)
      end
    end
  end
end

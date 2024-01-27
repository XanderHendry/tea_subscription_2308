module Api
  module V0
    class SubscriptionsController < ApplicationController
      before_action :set_tea, only: [:create]
      before_action :set_customer, only: [:create]
      rescue_from ActiveRecord::RecordNotUnique, with: :existing_record_response
      rescue_from ActionController::ParameterMissing, with: :parameter_missing_response

      def create
        sub = Subscription.create(subscription_params)
        render json: SubscriptionsSerializer.new(sub), status: :created
      end

      def destroy
        sub = Subscription.find(params[:id])
        sub.update(status: 1)
        render json: SubscriptionsSerializer.new(sub), status: :ok
      end

      private

      def subscription_params
        params.require([:customer_id, :tea_id, :frequency])
        params.permit(:customer_id, :tea_id, :frequency)
              .merge(
                      title: @tea.title,
                      price: @tea.price,
                      status: 0
                    )
      end
    
      def set_tea
        @tea = Tea.find(params[:tea_id])
      end

      def set_customer
        @customer = Customer.find(params[:customer_id])
      end

      def parameter_missing_response(exception)
        render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json, status: :bad_request
      end

      def existing_record_response(exception)
        render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).serialize_json, status: :unprocessable_entity
      end
    end
  end
end

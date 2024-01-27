module Api
  module V0
    class SubscriptionsController < ApplicationController
      before_action :set_tea, only: [:create]
      before_action :set_customer, only: [:index]

      def index
        subs = @customer.subscriptions
        render json: SubscriptionsSerializer.new(subs), status: :ok
      end

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
        params.permit(:customer_id, :tea_id, :frequency).merge(
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
    end
  end
end

module Api
  module V0
    class SubscriptionsController < ApplicationController
      before_action :set_tea, only: [:create]

      def create
        sub = Subscription.create(subscription_params)
        render json: SubscriptionsSerializer.new(sub), status: :created
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
    end
  end
end

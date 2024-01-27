class Subscription < ApplicationRecord
  validates :customer_id, :tea_id, :status, :frequency, presence: true
  belongs_to :customer
  belongs_to :tea
  validate :unique_subscription

  enum :status, ["Active", "Cancelled"]

  private

  def unique_subscription
    sub = Subscription.find_by(customer_id: self.customer_id, tea_id: self.tea_id)
    if sub && sub != self
      raise ActiveRecord::RecordNotUnique, "Customer is already enrolled in this Tea Subscription!"
    end
  end
end

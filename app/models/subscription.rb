class Subscription < ApplicationRecord
  validates :customer_id, :tea_id, :status, :frequency, presence: true
  belongs_to :customer
  belongs_to :tea

  enum :status, ["Active", "Cancelled"]
end

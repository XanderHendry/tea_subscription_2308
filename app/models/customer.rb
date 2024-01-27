class Customer < ApplicationRecord
  validates :first_name, :last_name, :email, :address, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  has_many :subscriptions
  has_many :teas, through: :subscriptions
end

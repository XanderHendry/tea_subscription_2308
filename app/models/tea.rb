class Tea < ApplicationRecord
  validates :title, :description, :temperature, :brew_time, :price, presence: true
  has_many :subscriptions
end

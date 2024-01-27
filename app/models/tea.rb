class Tea < ApplicationRecord
  validates :title, :description, :temperature, :brew_time, presence: true
  has_many :subscriptions
end

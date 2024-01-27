class AddForeignKeysToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_reference :subscriptions, :customer, foreign_key: true, null: false
    add_reference :subscriptions, :tea, foreign_key: true, null: false
  end
end

class AddPriceToTeas < ActiveRecord::Migration[7.1]
  def change
    add_column :teas, :price, :float
  end
end

class RemoveOrdersIdFromOrderDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_details, :orders_id, :integer
  end
end

class RemoveUpdatedAtFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :updated_at, :string
  end
end

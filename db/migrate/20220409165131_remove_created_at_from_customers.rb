class RemoveCreatedAtFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :created_at, :string
  end
end

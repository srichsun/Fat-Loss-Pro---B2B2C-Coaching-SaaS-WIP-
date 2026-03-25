class AddOrdersCountToTenants < ActiveRecord::Migration[8.2]
  def change
    add_column :tenants, :orders_count, :integer
  end
end

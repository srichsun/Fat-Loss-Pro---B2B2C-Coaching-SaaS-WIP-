class AddNameToUsers < ActiveRecord::Migration[8.2]
  def change
    add_column :users, :name, :string
  end
end

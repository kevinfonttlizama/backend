class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:users, :role)
      add_column :users, :role, :integer, default: 0
    end
  end
end

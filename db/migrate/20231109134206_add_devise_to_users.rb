class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      # If you already have an email column, you might not need this line.
      # Remove or comment it out if the column exists.
      # t.string :email,              null: false, default: ""

      # Add only the missing Devise columns.
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:users, :encrypted_password)

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

      ## Trackable
      # Add the rest only if they don't exist and if you want to use these modules
      # Uncomment and use `unless column_exists?` check as above if needed.

      ## Confirmable
      # Add the rest only if they don't exist and if you want to use these modules
      # Uncomment and use `unless column_exists?` check as above if needed.

      ## Lockable
      # Add the rest only if they don't exist and if you want to use these modules
      # Uncomment and use `unless column_exists?` check as above if needed.

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    # Only add index if it doesn't exist to avoid duplication errors
    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    # add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
    # add_index :users, :unlock_token, unique: true unless index_exists?(:users, :unlock_token)
  end

  def self.down
    # If you want to make this migration reversible, you'd have to manually specify which columns to remove.
    # For now, we'll raise an error to prevent accidental rollbacks.
    raise ActiveRecord::IrreversibleMigration
  end
end

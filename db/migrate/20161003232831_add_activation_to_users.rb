class AddActivationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :Boolean, default: false
  end
end

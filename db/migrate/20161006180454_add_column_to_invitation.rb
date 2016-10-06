class AddColumnToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :recipient_id, :integer
    add_column :invitations, :group_id, :integer
  end
end

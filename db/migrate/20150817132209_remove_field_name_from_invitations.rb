class RemoveFieldNameFromInvitations < ActiveRecord::Migration
  def change
    remove_column :invitations, :user_id, :string
  end
end

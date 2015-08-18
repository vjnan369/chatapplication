class AddFieldNameToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :session_id, :string
  end
end

class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :invited_by
      t.string :invited_mail
      t.string :session_id
      t.string :token
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :invitations, :users
    add_index :invitations, [:user_id, :created_at]
  end
end

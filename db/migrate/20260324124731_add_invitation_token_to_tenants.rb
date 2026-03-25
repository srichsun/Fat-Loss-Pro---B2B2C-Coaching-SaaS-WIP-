class AddInvitationTokenToTenants < ActiveRecord::Migration[8.2]
  def change
    add_column :tenants, :invitation_token, :string
    # Ensure O(1) lookup speed and global uniqueness for invitation links
    add_index :tenants, :invitation_token, unique: true
  end
end

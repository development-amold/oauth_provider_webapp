class RemoveOwnerIdFromOauthapplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :oauth_applications, :resource_owner_id, :integer
  end
end

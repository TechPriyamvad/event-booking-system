class RemovePasswordDigestFromEventOrganizers < ActiveRecord::Migration[7.1]
  def change
    remove_column :event_organizers, :password_digest, :string
  end
end

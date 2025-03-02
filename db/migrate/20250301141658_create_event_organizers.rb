class CreateEventOrganizers < ActiveRecord::Migration[6.1]
  def change
    create_table :event_organizers do |t|
      t.string :name
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest
      t.timestamps
    end
  end
end
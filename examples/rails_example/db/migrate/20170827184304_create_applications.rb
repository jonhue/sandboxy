class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.string :access_token, null: false
      t.string :sandbox_access_token, null: false

      t.timestamps
    end
  end
end

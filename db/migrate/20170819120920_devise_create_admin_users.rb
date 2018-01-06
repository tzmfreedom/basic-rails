class DeviseCreateAdminUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_users do |t|
      t.string :email
      t.string :password_digest
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end

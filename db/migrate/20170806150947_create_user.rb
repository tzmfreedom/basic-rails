class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password_digest
      t.boolean :active, default: true
      t.boolean :email_verified, default: false, null: false
      t.string :email_verify_token, unique: true
      t.datetime :email_verify_token_sent_at
      t.string :reset_password_token, unique: true
      t.datetime :reset_password_token_sent_at

      t.timestamps
    end
  end
end

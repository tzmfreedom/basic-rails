class CreateSocialProfile < ActiveRecord::Migration[5.1]
  def change
    create_table :social_profiles do |t|
      t.references :user, nil: false
      t.string :uid
      t.string :provider
      t.string :nickname

      t.timestamps
    end
  end
end

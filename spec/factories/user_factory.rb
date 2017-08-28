# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  single_access_token :string(255)
#  perishable_token    :string(255)
#  login_count         :integer          default(0), not null
#  failed_login_count  :integer          default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  active              :boolean          default(FALSE)
#  confirmed           :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :user do
    email 'hoge@example.com'
    password 'password'
    password_confirmation 'password'
    active true
    confirmed true
  end
end

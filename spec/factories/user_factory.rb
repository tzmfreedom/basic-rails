# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  nickname                     :string
#  email                        :string
#  password_digest              :string
#  active                       :boolean          default(TRUE)
#  email_verified               :boolean          default(FALSE), not null
#  email_verify_token           :string
#  email_verify_token_sent_at   :datetime
#  reset_password_token         :string
#  reset_password_token_sent_at :datetime
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
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

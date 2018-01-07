# == Schema Information
#
# Table name: admin_users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  active          :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class AdminUser < ApplicationRecord
  has_secure_password
end

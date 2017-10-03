# == Schema Information
#
# Table name: social_profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  uid        :string
#  provider   :string
#  nickname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SocialProfile < ApplicationRecord
  belongs_to :user

  def self.find_by_social_profile(params)
    find_by(provider: params[:provider],
            uid: params[:uid])
  end

  def self.build_parameter(params)
    klass = "::SocialProfile::#{params[:provider].capitalize}Parameter".constantize
    klass.new(params)
  end

  def create_from!(params)
    provider = SocialProfile.build_parameter(params)
    self.uid = params[:uid]
    self.provider = params[:provider]
    self.nickname = provider.nickname
    save!
  end

  class Parameter
    attr_accessor :params

    def initialize(params)
      @params = params
    end
  end

  class TwitterParameter < ::SocialProfile::Parameter
    def email
      params[:info][:email]
    end

    def nickname
      params[:info][:nickname]
    end
  end

  class FacebookParameter < ::SocialProfile::Parameter
    def email
      params[:info][:email]
    end

    def nickname
      params[:info][:name]
    end
  end

  class LineParameter < ::SocialProfile::Parameter
    def email
      params[:info][:email]
    end

    def nickname
      params[:info][:name]
    end
  end
end

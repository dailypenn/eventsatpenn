class User < ApplicationRecord
  attr_accessor :user_hash

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.full_name = auth['info']['name'] || ''
         user.first_name = auth['info']['first_name'] || ''
         user.last_name  = auth['info']['last_name'] || ''
         user.email = auth['info']['email'] || ''
         user.image_url = auth['info']['image'] || ""
      end
    end
  end
end

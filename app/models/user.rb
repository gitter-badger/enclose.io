class User < ApplicationRecord
  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :registerable, 
  devise :database_authenticatable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.login = auth.info.nickname
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.name = auth.info.name
     user.github_access_token = auth.credentials.token
   end
  end
  
  def github_client
    @github_client ||= Octokit::Client.new(access_token: github_access_token)
  end
end

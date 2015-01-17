class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, omniauth_providers: [:facebook]

  has_many :dogs, dependent: :destroy

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.first_name
      user.last_name = auth.last_name
      user.gender = auth.gender 
      user.image = auth.image
      user.urls = auth.urls
      user.verified = auth.verified
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.first_name
        user.last_name = auth.last_name
        user.gender = auth.gender 
        user.image = auth.image
        user.urls = auth.urls
        user.verified = auth.verified
      end
    end
  end

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end

end

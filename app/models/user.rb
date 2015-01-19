class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, omniauth_providers: [:facebook]
  # removed :registrable

  has_many :dogs, dependent: :destroy

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.nickname = auth.info.name
      user.name = auth.info.name
      user.gender = auth.extra.raw_info.gender 
      user.image = auth.info.image
      user.urls = auth.extra.raw_info.link
      user.verified = auth.extra.raw_info.verified
      user.save
      user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.nickname = auth.info.name
        user.name = auth.info.name
        user.gender = auth.extra.raw_info.gender 
        user.image = auth.info.image
        user.urls = auth.extra.raw_info.link
        user.verified = auth.extra.raw_info.verified
        user
      end
    end
  end

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end

  def has_location?
    [home_lat, home_long].all?
  end
end

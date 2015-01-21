class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registrable, :confirmable, :lockable, :timeoutable and :omniauthable
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  geocoded_by :postcode, latitude: :home_lat, longitude: :home_long
  after_validation :geocode, :if => :postcode_changed?

  devise :database_authenticatable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, omniauth_providers: [:facebook]

  mount_uploader :image, UserImageUploader

  has_many :dogs, dependent: :destroy
  acts_as_messageable

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
      user.role = "user"
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
        user.role = "user"
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

  def has_postcode?
    postcode?
  end

  def current_user_log?
    current_user?
  end

  #this is a method for the mailboxer gem
  def name
    return nickname
  end

  def mailboxer_email(object)
    email
  end

end

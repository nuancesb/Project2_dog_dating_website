class Dog < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, DogImageUploader
  mount_uploader :sound, DogSoundUploader

end

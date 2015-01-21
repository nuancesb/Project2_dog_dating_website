class UserSerializer < ActiveModel::Serializer
  attributes :id, :home_lat, :home_long, :name, :postcode

  has_many :dogs
end

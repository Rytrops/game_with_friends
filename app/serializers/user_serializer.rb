class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :steam_id, :steam_vanity, :steam_url, :email

  has_many :videogames
end

class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :steam_id, :steam_vanity, :steam_url, :email, :id

  has_many :videogames
end

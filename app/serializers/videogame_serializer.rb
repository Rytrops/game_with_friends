class VideogameSerializer
  include JSONAPI::Serializer
  attributes :game_name, :developer, :number_of_players
end

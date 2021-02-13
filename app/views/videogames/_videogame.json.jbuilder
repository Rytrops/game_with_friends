json.extract! videogame, :id, :game_, :name, :developer, :game_type, :number_of_players, :created_at, :updated_at
json.url videogame_url(videogame, format: :json)

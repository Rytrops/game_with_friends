json.extract! videogame, :id, :game_name, :developer, :number_of_players, :created_at, :updated_at
json.url videogame_url(videogame, format: :json)

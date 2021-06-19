# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: 'Test User 1', email: 'test_email@email.com', steam_url: 'https://steamcommunity.com/profiles/76561198068892037', password: '123456')
User.create(username: 'Test User 2', email: 'test_email2@email.com', steam_url: 'https://steamcommunity.com/id/FifthSurprise/', password: '123456')

game_1 = Videogame.create(game_name: 'Sample Game 1', developer: 'Game Dev 1', number_of_players: 3)
game_2 = Videogame.create(game_name: 'Sample Game 2', developer: 'Game Dev 1', number_of_players: 5)
game_3 = Videogame.create(game_name: 'Sample Game 2', developer: 'Game Dev 2', number_of_players: 2)
game_4 = Videogame.create(game_name: 'Sample Game 3', developer: 'Game Dev 2', number_of_players: 4)
game_5 = Videogame.create(game_name: 'Sample Game 4', developer: 'Game Dev 3', number_of_players: 10)

User.first.videogames << game_1 << game_2
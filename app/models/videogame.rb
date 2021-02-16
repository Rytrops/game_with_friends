class Videogame < ApplicationRecord
    has_many :users_videogames
    has_many :users, through: :users_videogames
end

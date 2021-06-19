class Videogame < ApplicationRecord
    has_many :users_videogames
    has_many :users, through: :users_videogames

    validates :game_name, presence: true, uniqueness: { case_sensitive: false }
end

class UsersVideogame < ApplicationRecord
    belongs_to :user
    belongs_to :videogame
end

class User < ApplicationRecord
    has_many :users_videogames
    has_many :videogames, through: :users_videogames

    validates :username, presence: true
    validates :email_address, presence: true                    

end

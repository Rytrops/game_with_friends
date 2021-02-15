class User < ApplicationRecord

    has_many :videogames

    validates :username, presence: true
    validates :email_address, presence: true                    

end

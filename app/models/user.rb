class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :users_videogames
    has_many :videogames, through: :users_videogames

    validates :username, presence: true
    validates :email, presence: true                    

end

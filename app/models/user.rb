class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation:update_steamID
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :users_videogames
    has_many :videogames, through: :users_videogames

    validates :username, presence: true
    validates :email, presence: true    
  
  
  
  
  private
  def update_steamID

    unless self.steam_url && self.steam_id
      self.steam_id = extrapolate_steamID(self.steam_url)
    end
  end

  def extrapolate_steamID(string_url)
      steam_id = string_url.split("/")[4]
  end

end

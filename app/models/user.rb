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
      # I use the 4 index because thats where the id occurs, this assumes my user is acting in good faith and doesnt supply the wrong link. Should make thise more robust later.
      steam_id = string_url.split("/")[4]
  end

end

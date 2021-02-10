class User < ApplicationRecord

    validates :username, presence: true
    validates :email_address, presence: true                    

end

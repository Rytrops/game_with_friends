class AddUserTovideogames < ActiveRecord::Migration[6.1]
  def change
    add_reference :videogames, :user
  end
end

class CreateUsersVideogames < ActiveRecord::Migration[6.1]
  def change
    create_table :users_videogames do |t|
      t.integer :user_id
      t.integer :videogame_id

      t.timestamps
    end
  end
end

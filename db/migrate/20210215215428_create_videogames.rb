class CreateVideogames < ActiveRecord::Migration[6.1]
  def change
    create_table :videogames do |t|
      t.string :game_name
      t.string :developer
      t.integer :number_of_players

      t.timestamps
    end
  end
end

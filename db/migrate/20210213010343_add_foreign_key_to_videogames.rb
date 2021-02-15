class AddForeignKeyToVideogames < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :videogames, :users
  end
end

class AddVideogamesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :game_name, :string
  end
end

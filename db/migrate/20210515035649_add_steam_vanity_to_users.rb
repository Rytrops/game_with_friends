class AddSteamVanityToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :steam_vanity, :string
  end
end

class AddSteamUrlToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :steam_url, :string
  end
end

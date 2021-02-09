class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email_address
      t.string :steam_id
      
      t.timestamps
    end
  end
end

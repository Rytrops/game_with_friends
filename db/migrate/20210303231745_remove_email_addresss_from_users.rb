class RemoveEmailAddresssFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :email_address, :string
  end
end

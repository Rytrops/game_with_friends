class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :review_id
      t.integer :user_id
      t.integer :videogame_id

      t.string :title
      t.text :body

      t.timestamps
    end
  end
end

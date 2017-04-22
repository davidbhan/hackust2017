class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :heading
      t.text :description
      t.integer :price
      t.string :location
      t.integer :rating
      t.string :external_url
      t.string :timestamp

      t.timestamps
    end
  end
end

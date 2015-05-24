class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :name
      t.text :year
      t.text :score
      t.text :rating
      t.text :genres
      t.text :length
      t.text :cast
      t.text :freshness
      t.text :description
      t.text :imageLink

      t.timestamps null: false
    end
  end
end

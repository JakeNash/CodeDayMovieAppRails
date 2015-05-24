class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :name
      t.text :data

      t.timestamps null: false
    end
  end
end

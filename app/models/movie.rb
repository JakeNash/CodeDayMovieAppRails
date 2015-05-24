class Movie < ActiveRecord::Base
  searchable do
    text :name, :year, :score, :rating, :genres, :length, :cast, :freshness, :description, :imageLink
  end
end

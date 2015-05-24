json.array!(@movies) do |movie|
  json.extract! movie, :id, :name, :year, :score, :rating, :genres, :length, :cast, :freshness, :description, :imageLink
  json.url movie_url(movie, format: :json)
end

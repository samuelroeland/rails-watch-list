require 'faker'
require 'json'
require 'open-uri'
url = "https://tmdb.lewagon.com/movie/top_rated"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Destroying all movies"
Movie.destroy_all

puts "Creating movies..."
user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)
user['results'].each do |result|
  movie = Movie.create(
    title: result["original_title"],
    overview: result["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{result['poster_path']}",
    rating: result["vote_average"]
  )
  puts "creating movie with id: #{movie.id}"
end


puts "Finished."

# create_table "movies", force: :cascade do |t|
#   t.string "title"
#   t.text "overview"
#   t.string "poster_url"
#   t.integer "rating"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

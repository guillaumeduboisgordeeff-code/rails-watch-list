require "open-uri"
require "json"
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#1 Destroy all movies
puts "destroying all previous movie instances..."
Movie.destroy_all

#2 Creating 10 movies
puts "creating new movies"

url = "https://tmdb.lewagon.com/movie/top_rated"

# a call api
call_api = URI.open(url).read
# b parse JSON resul
data = JSON.parse(call_api)
# c get results for 10 movie
data["results"].first(10).each do |result|
  Movie.create!(
    title: result["title"], 
    overview: result["overview"],
    poster_url: "https://tmdb.org#{result["poster_path"]}",
    rating: result["vote_average"]
    )
end

puts "#{Movie.count} new movies created"

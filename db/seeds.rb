require 'open-uri'
require 'json'

puts "Nettoyage de la base de données..."
Bookmark.destroy_all
Movie.destroy_all

puts "Démarrage de l'importation des films..."

url = "https://tmdb.lewagon.com/movie/top_rated"

serialized_data = URI.open(url).read

movies_data = JSON.parse(serialized_data)

movies = movies_data['results']

movies.each do |movie_hash|
  puts "Création de #{movie_hash['title']}..."


  base_poster_url = "https://image.tmdb.org/t/p/original"
  full_poster_url = "#{base_poster_url}#{movie_hash['poster_path']}"

  Movie.create!(
    title: movie_hash['title'],
    overview: movie_hash['overview'],
    poster_url: full_poster_url,
    rating: movie_hash['vote_average'] 
  )
end

puts "Terminé ! #{Movie.count} films importés avec succès."

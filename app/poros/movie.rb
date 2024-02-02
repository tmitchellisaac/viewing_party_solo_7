class Movie 
  attr_reader :id,
              :title,
              :rating,
              :runtime,
              :runtime_min,
              :genres,
              :description,
              :cast,
              :review_count,
              :review_authors,
              :poster

  def initialize(data)
    @id = data.first[:id]
    @title = data.first[:title]
    @rating = data.first[:vote_average]
    @runtime_min = data.first[:runtime]
    @runtime = "#{data.first[:runtime]/60} hours and #{data.first[:runtime] % 60} minutes"
    @genres = data.first[:genres].map { |line| line[:name] }
    @description = data.first[:overview]
    @cast =  {} 
      data.second.map do |member| 
         @cast[member[:name]] = member[:character] 
      end
    @review_count = data.third[:results].count
    @review_authors = data.third[:results].map do |review|
      ReviewAuthor.new(review[:author_details])
    end
    @poster = "https://media.themoviedb.org/t/p/original#{data.first[:poster_path]}"
  end
end

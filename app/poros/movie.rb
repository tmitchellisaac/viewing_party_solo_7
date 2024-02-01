class Movie 
  attr_reader :id,
              :title,
              :rating,
              :runtime,
              :genres,
              :description,
              :cast,
              :review_count,
              :review_authors

  def initialize(data1, data2, data3)
    @id = data1[:id]
    @title = data1[:title]
    @rating = data1[:vote_average]
    @runtime = "#{data1[:runtime]/60} hours and #{data1[:runtime] % 60} minutes"
    @genres = data1[:genres].map { |line| line[:name] }
    @description = data1[:overview]
    @cast =  {} 
      data2[:cast].take(10).map do |member| 
         @cast[member[:name]] = member[:character] 
      end
    @review_count = data3[:results].count
    @review_authors = data3[:results].map do |review|
      ReviewAuthor.new(review[:author_details])
    end
  end
end

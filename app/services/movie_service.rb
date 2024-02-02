class MovieService

  def conn
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
    faraday.params["api_key"] = Rails.application.credentials.the_movie_db[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def top_rated_movies
    json = get_url("3/movie/top_rated")
    json[:results]
  end

  def search_movies(query)
    json = get_url("3/search/movie?query=#{query}")
    json[:results]
  end

  def find_movie(id)
    json_gen = get_url("3/movie/#{id}")
    json_credits = get_url("3/movie/#{id}/credits")[:cast].take(10)
    json_reviews = get_url("3/movie/#{id}/reviews")
    [json_gen, json_credits, json_reviews]
  end

end

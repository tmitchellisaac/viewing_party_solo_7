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
    get_url("3/movie/top_rated")[:results]
  end

  def search_movies(query)
    get_url("3/search/movie?query=#{query}")[:results]
  end

  def find_movie(id)
    json_gen = get_url("3/movie/#{id}")
    json_credits = get_url("3/movie/#{id}/credits")[:cast].take(10)
    json_reviews = get_url("3/movie/#{id}/reviews")
    [json_gen, json_credits, json_reviews]
  end

  def watch(id)
    get_url("3/movie/#{id}/watch/providers")[:results][:US]
  end

end

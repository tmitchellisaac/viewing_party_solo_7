class UserMoviesController < ApplicationController

  def index
    @user = User.find(params[:user_id])

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = "1311ab65df93d5e9a0eb12ab57bac784"
    end
    if params[:s]
      response = conn.get("3/search/movie?query=#{params[:s]}")
      json = JSON.parse(response.body, symbolize_names: true)
      @search_results = json[:results]
    else 
    
      response = conn.get("3/movie/top_rated")
      json = JSON.parse(response.body, symbolize_names: true)
      @top_rated = json[:results]
    end  

  end

  def show
    @user = User.find(params[:user_id])

    id = params[:id].to_i

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.the_movie_db[:key]
    end

    response_gen = conn.get("3/movie/#{id}")
    response_credits = conn.get("3/movie/#{id}/credits")
    response_reviews = conn.get("3/movie/#{id}/reviews")

    data1 = JSON.parse(response_gen.body, symbolize_names: true)
    data2 = JSON.parse(response_credits.body, symbolize_names: true)
    data3 = JSON.parse(response_reviews.body, symbolize_names: true)


    @movie = Movie.new(data1, data2, data3)

  end
end
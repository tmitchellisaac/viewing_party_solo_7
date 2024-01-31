class UserMoviesController < ApplicationController

  def index
    @user = User.find(params[:user_id])

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = "1311ab65df93d5e9a0eb12ab57bac784"
    end

    if params[:q]
      require 'pry'; binding.pry
      response = conn.get("3/search/movie?query=#{params[:q]}")
      json = JSON.parse(response.body, symbolize_names: true)
      @search_results = json[:results]
    else 
      response = conn.get("/3/movie/top_rated")
      json = JSON.parse(response.body, symbolize_names: true)
      @top_rated = json[:results]
    end  

  end

  def show

  end
end
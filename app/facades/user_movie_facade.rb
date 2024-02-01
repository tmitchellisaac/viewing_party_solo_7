class UserMovieFacade

  def initialize(user_id)
    @user_id = user_id
  end

  def movies
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

end
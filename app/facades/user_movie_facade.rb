class UserMovieFacade
  
  attr_reader :user_id, :movie

  def initialize(params)
    @params = params
    @user_id = params[:user_id]
  end

  def movies
    service = MovieService.new
    if @params[:q] == "top rated"
      service.top_rated_movies
    else
      service.search_movies(@params[:q])
    end
  end

  def movie_id
    @params[:id]
  end

  def movie
    service = MovieService.new
    @movie = Movie.new(service.find_movie(movie_id))
  end
end

class ViewingPartyFacade
  attr_reader :user_id, :movie_id

  def initialize(params)
    @user_id = params[:user_id]
    @movie_id = params[:movie_id]
  end

  def movie
    service = MovieService.new
    @movie = Movie.new(service.find_movie(@movie_id))
  end

  def users
    User.all
  end

end
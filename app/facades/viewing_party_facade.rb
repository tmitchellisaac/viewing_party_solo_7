class ViewingPartyFacade
  attr_reader :user_id, :movie_id

  def initialize(params)
    @user_id = params[:user_id]
    @movie_id = params[:movie_id]
    @params = params
  end

  def movie
    service = MovieService.new
    @movie = Movie.new(service.find_movie(@movie_id))
  end

  def users
    User.all
  end

  def attendee_ids
    attending = @params.select { |k,v| v == "1" }.keys
  end
  
  def create_user_parties(v_party)
    attendee_ids.each do |id| 
      v_party.user_parties.create(host: @user_id == id, user_id: id) 
    end
  end

end
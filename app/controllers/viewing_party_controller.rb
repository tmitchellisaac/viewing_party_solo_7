class ViewingPartyController < ApplicationController

  def new
    @facade = ViewingPartyFacade.new(params)
  end

  def create
    @facade = ViewingPartyFacade.new(params)

    @view_party = ViewingParty.create(
      duration: params[:duration],
      date: params[:date],
      start_time: params[:start_time],
      movie_id: params[:movie_id],
      movie_title: @facade.movie.title
    )
    @facade.create_user_parties(@view_party)
  
    redirect_to "/users/#{@facade.user_id}"
  end

  private

  def strong_params
    params.permit(:duration, :date, :start_time, :movie_id)

  end

end
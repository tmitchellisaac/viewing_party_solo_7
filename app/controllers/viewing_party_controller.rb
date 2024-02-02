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

    def find_users
      attending = params.select do |key,value|
        value == "1"
      end
      attending.keys.map do |key|
        key
      end
    end
    
    def create_attendees
      find_users.each do |attendee_id|
        @view_party.user_parties.create(host: (params[:user_id] == attendee_id), user_id: attendee_id)
      end
    end
    create_attendees

    redirect_to "/users/#{@facade.user_id}"
  end

end
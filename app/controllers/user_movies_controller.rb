class UserMoviesController < ApplicationController

  def index
    @facade = UserMovieFacade.new(params)
  end

  def show
    @facade = UserMovieFacade.new(params)
  end
end
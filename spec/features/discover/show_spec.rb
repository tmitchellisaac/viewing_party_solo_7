require 'rails_helper'

RSpec.describe 'Discover page', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user_2 = User.create!(name: 'Sam', email: 'sam@email.com')

  end

  it "has a button to discover top rated movies" do
    visit "/users/#{@user_1.id}/discover"

    expect(page).to have_link("Find Top Rated Movies")
    expect(page).to have_content("Search for movies")
  #   As a user,
  #   When I visit the '/users/:id/discover' path (where :id is the id of a valid user),
  #   I should see
  # - a Button to Discover Top Rated Movies
  # - a text field to enter keyword(s) to search by movie title
  # - a Button to Search by Movie Title

  end


end
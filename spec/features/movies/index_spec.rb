require 'rails_helper'

RSpec.describe 'Movies index page', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user_2 = User.create!(name: 'Sam', email: 'sam@email.com')

  end

  it "has a list of 20 top movies with name and rating" do
    json_response = File.read('spec/fixtures/top_rated_movies.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=1311ab65df93d5e9a0eb12ab57bac784").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
    to_return(status: 200, body: json_response, headers: {})

    visit "/users/#{@user_1.id}/discover"
    click_link "Find Top Rated Movies"
    expect(current_path).to eq("/users/#{@user_1.id}/movies")
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to have_content("The Godfather")
    expect(page).to have_content("The Godfather Part II")
    expect(page).to have_content("Schindler's List")
    expect(page).to have_content("12 Angry Men")
    expect(page).to have_content("Dilwale Dulhania Le Jayenge")
    expect(page).to have_content("Spirited Away")
    expect(page).to have_content("The Dark Knight")
    expect(page).to have_content(" Parasite")
    expect(page).to have_content("The Green Mile")
    expect(page).to have_content("Your Name.")
    expect(page).to have_content("Pulp Fiction")
    expect(page).to have_content("The Lord of the Rings: The Return of the King")
    expect(page).to have_content("Forrest Gump")
    expect(page).to have_content("The Good, the Bad and the Ugly")
    expect(page).to have_content("8.711")
    expect(page).to have_content("8.707")
    expect(page).to have_content("8.591")
    expect(page).to have_content("8.572")
    expect(page).to have_content("8.547")
    expect(page).to have_content("8.541")

    expect(page).to have_content("Discover Page")

  end

  it "has a list of movies based on search results that match title" do
    json_response = File.read('spec/fixtures/movie_query_god.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=1311ab65df93d5e9a0eb12ab57bac784&query=God").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    visit "/users/#{@user_1.id}/discover"
    
    fill_in :s, with: "God"
    click_button "Search"
    expect(current_path).to eq("/users/#{@user_1.id}/movies")
    expect(page).to have_content("Godzilla Minus One")
    expect(page).to have_content("El padrino: The Latin Godfather")
    expect(page).to have_content("All the Names of God")
    expect(page).to have_content("Godzilla: The Planet Eater")
    expect(page).to have_content("Godzilla: City on the Edge of Battle")
    expect(page).to have_content("God")
    expect(page).to have_content("7.894")
    expect(page).to have_content("6.8")
    expect(page).to have_content("6.648")
    expect(page).to have_content("7.5")
    expect(page).to have_content("6.426")

    expect(page).to have_content("Discover Page")
  end
end
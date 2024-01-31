require 'rails_helper'

RSpec.describe 'Movies show page', type: :feature do
  before(:each) do
    @salt_gen = File.read("spec/fixtures/saltburn_movie_gen.json")
    @salt_cast = File.read("spec/fixtures/saltburn_movie_cast.json") 
    @salt_review = File.read("spec/fixtures/saltburn_movie_reviews.json") 

    @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user_2 = User.create!(name: 'Sam', email: 'sam@email.com')
    # @movie_1 = Movie.new(@salt_gen, @salt_cast, @salt_review)
  end

  it "has a button to create a viewing party and to return to discover page" do

    stub_request(:get, "https://api.themoviedb.org/3/movie/930564?api_key=1311ab65df93d5e9a0eb12ab57bac784").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: @salt_gen, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/movie/930564/credits?api_key=1311ab65df93d5e9a0eb12ab57bac784").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: @salt_cast, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/movie/930564/reviews?api_key=1311ab65df93d5e9a0eb12ab57bac784").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: @salt_review, headers: {})

    visit "/users/#{@user_1.id}/movies/930564"

    expect(page).to have_content("Discover Page")
    expect(page).to have_content("Create Viewing Party")

  end

  xit "has attribute/info about movie" do
    visit "/users/#{@user_1.id}/movies/#{@movie_1.id}"



  end

end
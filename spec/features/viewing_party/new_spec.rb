require 'rails_helper'

RSpec.describe 'Viewing Party Create Page', type: :feature do
  before(:each) do
    @salt_gen = File.read("spec/fixtures/saltburn_movie_gen.json")
    @salt_cast = File.read("spec/fixtures/saltburn_movie_cast.json") 
    @salt_review = File.read("spec/fixtures/saltburn_movie_reviews.json") 

    @user_1 = User.create!(name: 'Isaac', email: 'isaac@email.com')
    @user_2 = User.create!(name: 'Jessie', email: 'jessie@email.com')
    # @movie_1 = Movie.new(@salt_gen, @salt_cast, @salt_review)
  end
  it "has a new viewing parting page" do

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

    visit "/users/#{@user_1.id}/movies/930564/viewing_party/new"

    expect(page).to have_content("Saltburn")

    expect(page).to have_field("date")
    expect(page).to have_field("start_time")
    expect(page).to have_content("Isaac@email.com")
    expect(page).to have_content("Jessie@email.com")

    fill_in "duration", with: 145
    fill_in "date", with: Date.new(2024,3,3)
    fill_in "start_time", with: "7:00"
    check "#{@user_1.id}"
    check "#{@user_2.id}"
    click_button "Create Party"

    us_p_1 = UserParty.all.first
    us_p_2 = UserParty.all.second
    
    expect(current_path).to eq("/users/#{@user_1.id}")
    expect(us_p_1.host).to eq(true)

    visit "/users/#{@user_2.id}"
    save_and_open_page
    expect(page).to have_content("Saltburn")
    expect(us_p_2.host).to eq(false)
    
  end


end
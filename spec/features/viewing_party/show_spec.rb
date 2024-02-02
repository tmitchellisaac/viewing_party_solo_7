require "rails_helper"

RSpec.describe "Viewing Party Show Page" do
  before(:each) do
    @salt_gen = File.read("spec/fixtures/saltburn_movie_gen.json")
    @salt_cast = File.read("spec/fixtures/saltburn_movie_cast.json") 
    @salt_review = File.read("spec/fixtures/saltburn_movie_reviews.json") 

    @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user_2 = User.create!(name: 'Sam', email: 'sam@email.com')
  
    @viewing_party_1 = ViewingParty.create(duration: 145, date: "2024-02-14", start_time: "07:00", movie_id: 930564, movie_title: "Saltburn")
    @user_party_1 = @viewing_party_1.user_parties.create(user_id: @user_1.id, host: true)
    @user_party_2 = @viewing_party_1.user_parties.create(user_id: @user_2.id, host: false)

  #   stub_request(:get, "https://api.themoviedb.org/3/movie/930564?api_key=1311ab65df93d5e9a0eb12ab57bac784").
  #   with(
  #     headers: {
  #    'Accept'=>'*/*',
  #    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #    'User-Agent'=>'Faraday v2.9.0'
  #     }).
  #   to_return(status: 200, body: @salt_gen, headers: {})

  # stub_request(:get, "https://api.themoviedb.org/3/movie/930564/credits?api_key=1311ab65df93d5e9a0eb12ab57bac784").
  #   with(
  #     headers: {
  #    'Accept'=>'*/*',
  #    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #    'User-Agent'=>'Faraday v2.9.0'
  #     }).
  #   to_return(status: 200, body: @salt_cast, headers: {})

  # stub_request(:get, "https://api.themoviedb.org/3/movie/930564/reviews?api_key=1311ab65df93d5e9a0eb12ab57bac784").
  #   with(
  #     headers: {
  #    'Accept'=>'*/*',
  #    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #    'User-Agent'=>'Faraday v2.9.0'
  #     }).
  #   to_return(status: 200, body: @salt_review, headers: {})

  end

  it "has logos for purchase and rental and Justwatch" do
    watch_providers = File.read("spec/fixtures/shawshank_watch_providers.json")
    stub_request(:get, "https://api.themoviedb.org/3/movie/768/watch/providers?api_key=1311ab65df93d5e9a0eb12ab57bac784").
      with(
      headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.9.0'
      }).
      to_return(status: 200, body: watch_providers, headers: {})


    visit "/users/#{@user_1.id}/movies/768/viewing_party/#{@viewing_party_1.id}"

    expect(page).to have_content("Where to Buy")
    expect(page).to have_content("Where to Rent")

    within "#buy" do
      expect(page).to have_content("Apple TV")
      expect(page).to have_content("Amazon Video")
      expect(page).to have_content("Google Play Movies")
      expect(page).to have_content("YouTube")
      expect(page).to have_content("Microsoft Store")
      expect(page).to have_content("DIRECTV")
    end

    within "#rent" do
      expect(page).to have_content("Apple TV")
      expect(page).to have_content("Amazon Video")
      expect(page).to have_content("Google Play Movies")
      expect(page).to have_content("YouTube")
      expect(page).to have_content("Microsoft Store")
      expect(page).to have_content("DIRECTV")
      expect(page).to_not have_content("AMC on Demand")
    end

  end

end
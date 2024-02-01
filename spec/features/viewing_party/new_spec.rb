require 'rails_helper'

RSpec.describe 'Viewing Party Create Page', type: :feature do
  before(:each) do
    @salt_gen = File.read("spec/fixtures/saltburn_movie_gen.json")
    @salt_cast = File.read("spec/fixtures/saltburn_movie_cast.json") 
    @salt_review = File.read("spec/fixtures/saltburn_movie_reviews.json") 

    @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user_2 = User.create!(name: 'Jessie', email: 'sam@email.com')
    # @movie_1 = Movie.new(@salt_gen, @salt_cast, @salt_review)
  end
  it "has a new viewing parting page" do
    visit "/users/#{@user_1.id}/movies/930564/viewing_party/new"

    expect(page).to have_content("Saltburn")
    expect(page).to have_form("Create Viewing Party")

    expect(page).to have_field("date")
    expect(page).to have_field("start time")
    expect(page).to have_box("Tommy")
    expect(page).to have_box("Sam")

    fill_in "date", with: "date"
    fill_in "start time", with: "7:00"
    check_box "Tommy"
    check_box "Jessie"
    click_button "Create Party"

    expect(current_path).to eq("/users/#{@user_1}")
    expect(@user_1.host).to eq(true)

    visit "/users/#{@user_2}"
    expect(page).to have_content("Saltburn")
    expect(@user_2.host).to eq(false)
    
  end


end
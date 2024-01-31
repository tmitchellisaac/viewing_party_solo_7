require 'rails_helper'

RSpec.describe 'Movies index page', type: :feature do
  it "has a list of 20 top movies with name and rating" do
    visit "/users/#{@user_1.id}/discover"
    click_link "Find Top Rated Movies"
    expect(current_path).to eq("users/#{@user_1.id}/movies")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")
    expect(page).to have_content("Shawshank Redemption")

    
  end

  it "has a list of movies based on search results that match title" do



  end
end
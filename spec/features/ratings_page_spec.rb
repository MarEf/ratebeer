require 'rails_helper'
include OwnTestHelper

describe "Ratings page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
		user.ratings << FactoryGirl.create(:rating, beer:beer)
    user.ratings << FactoryGirl.create(:rating2, beer:beer)
  end

	it "lists ratings and their total number" do
		visit ratings_path
		expect(page).to have_content "Number of ratings: 2"
    @ratings.each do |rating|
      expect(page).to have_content rating
    end
	end
end

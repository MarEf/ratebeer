require 'rails_helper'
include OwnTestHelper

describe "On individual user's page" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user){ FactoryGirl.create(:user) }
	let!(:user2){ FactoryGirl.create(:user, username:"Mikko") }
	
	before :each do
    sign_in(username:"Pekka", password:"Foobar1")
		user.ratings << FactoryGirl.create(:rating, beer:beer)
    user.ratings << FactoryGirl.create(:rating2, beer:beer)
		user2.ratings << FactoryGirl.create(:rating, beer:beer, score:30)
  end

	it "displays user's own ratings" do
		visit user_path(user)
		user.ratings.each do |rating|
      expect(page).to have_content rating
    end
	end

	it "does not display other user's ratings" do
		visit user_path(user)

		user2.ratings.each do |rating|
      expect(page).to_not have_content rating
    end		
	end
end

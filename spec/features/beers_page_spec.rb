require 'rails_helper'
include OwnTestHelper

describe "Beers page" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	let!(:user) { FactoryGirl.create :user}

	it "allows a new beer to be created from the webpage" do
		sign_in(username:"Pekka", password:"Foobar1")
		visit new_beer_path

		fill_in('beer_name', with:'Valid')
		expect{
			click_button "Create Beer"
		}.to change{Beer.count}.from(0).to(1)
	end

	it "does not permit beer creation without a name" do
		sign_in(username:"Pekka", password:"Foobar1")
		visit new_beer_path

		click_button "Create Beer"

		expect(current_path).to eq(beers_path)
		expect(page).to have_content "New Beer"
		expect(page).to have_content "Name can't be blank"
	end
end

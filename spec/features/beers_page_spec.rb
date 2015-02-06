require 'rails_helper'

describe "Beers page" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

	it "allows a new beer to be created from the webpage" do
		visit beers_path
		click_link "New Beer"

		fill_in('beer[name]', with:'Valid')
		expect{
			click_button "Create Beer"
		}.to change{Beer.count}.from(0).to(1)
	end

	it "does not permit beer creation without a name" do
		visit beers_path
		click_link "New Beer"
		click_button "Create Beer"

		expect(page).to have_content "Name can't be blank"
	end
end

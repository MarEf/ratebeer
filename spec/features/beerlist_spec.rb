require 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js: true do
    visit beerlist_path
		find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

	it "shows beers sorted by name by default" do
		visit beerlist_path
		find('table').find('tr:nth-child(2)')
		page.should have_content("tr:nth-child(2)", content: "Fastenbier")
		page.should have_content("tr:nth-child(3)", content: "Lechte Weisse")
		page.should have_content("tr:nth-child(4)", content: "Nikolai")
	end
	
	it "shows beers sorted by style if style column is clicked"
		visit beerlist_path
		find('table').find('tr:nth-child(2)')
		click_link("Style")
		find('table').find('tr:nth-child(2)')
		
		page.should have_content("tr:nth-child(3)", content: "Fastenbier")
		page.should have_content("tr:nth-child(4)", content: "Lechte Weisse")
		page.should have_content("tr:nth-child(2)", content: "Nikolai")
	do

	it "shows beers sorted by brewery when brewery column is clicked" do
		visit beerlist_path
		find('table').find('tr:nth-child(2)')
		click_link("Brewery")
		find('table').find('tr:nth-child(2)')
		
		page.should have_content("tr:nth-child(4)", content: "Fastenbier")
		page.should have_content("tr:nth-child(2)", content: "Lechte Weisse")
		page.should have_content("tr:nth-child(3)", content: "Nikolai")
	end
end



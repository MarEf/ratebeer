require 'rails_helper'

describe Beer do
  it "is saved with name and style given" do
		beer =  Beer.create name:"Iso 3", style:"Lager"

		expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
	end

	it "is not saved without a name" do
		beer = Beer.create style:"Lager"

		expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
	end

	it "is not saved without a style" do
		beer = Beer.create name:"Iso"

		expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
	end
end
require 'rails_helper'

describe Beer do
	let!(:style) { FactoryGirl.create :style}
  it "is saved with name and style given" do
		beer =  Beer.create name:"Iso 3", style:1

		expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
	end

	it "is not saved without a name" do
		beer = Beer.create, style:1

		expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
	end

	it "is not saved without a style" do
		beer = Beer.create name:"Iso"

		expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
	end
end

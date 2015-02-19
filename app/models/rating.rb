class Rating < ActiveRecord::Base
	belongs_to :beer
	belongs_to :user

	validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  def to_s
		return "#{beer.name}: #{score}"
  end

	def self.latest(n)
		latest_ratings = Rating.all.last(n)
		return latest_ratings.reverse!
	end
end

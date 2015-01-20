class Beer < ActiveRecord::Base
belongs_to :brewery
has_many :ratings

	def average_rating
		return "#{ratings.average(:score)}"
	end

	def to_s
		return "#{name}, #{brewery.name}"
	end
end

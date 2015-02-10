class User < ActiveRecord::Base
	include RatingAverage	

	has_secure_password

	validates :username, uniqueness: true,
											 length: { minimum: 3,
                                 maximum: 15}
	validates :password, length: { minimum: 4 },
											 format: {with: /(?=.*[A-Z])(?=.*\d)/, #If I ever see these again it will be too soon...
											 message: "Password needs to have at least one capital letter and one number."}	

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships

	def favorite_beer
		return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
	end

end

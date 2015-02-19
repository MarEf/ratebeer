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


  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_brewery
    return nil if ratings.empty?
    brewery_ratings = rated_breweries.inject([]) do |ratings, brewery|
      ratings << {
        name: brewery,
        rating: rating_of_brewery(brewery) }
    end

    brewery_ratings.sort_by { |brewery| brewery[:rating] }.reverse.first[:name]
  end

  def favorite_style
    return nil if ratings.empty?
    style_ratings = rated_styles.inject([]) do |ratings, style|
      ratings << {
        name: style,
        rating: rating_of_style(style) }
    end

    style_ratings.sort_by { |style| style[:rating] }.reverse.first[:name]
  end

  def rated_breweries
    ratings.map{ |r| r.beer.brewery }.uniq
  end

  def rated_styles
    ratings.map{ |r| r.beer.style }.uniq
  end

  def rating_of_brewery(brewery)
    ratings_of_brewery = ratings.select do |r|
      r.beer.brewery == brewery
    end
    ratings_of_brewery.map(&:score).sum / ratings_of_brewery.count
  end

  def rating_of_style(style)
    ratings_of_style = ratings.select do |r|
      r.beer.style == style
    end
    ratings_of_style.map(&:score).sum / ratings_of_style.count
  end

	def self.top_raters(n)
    sorted_by_ratings_in_desc_order = User.all.sort_by{ |u| -(u.ratings.count||0) }
		return sorted_by_ratings_in_desc_order.take(n)
 	end
end

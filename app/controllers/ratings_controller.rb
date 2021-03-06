class RatingsController < ApplicationController
	before_action :skip_if_cached, only:[:index]
	before_action :expire_related_cache, only:[:create, :destroy]

  def skip_if_cached
    return render :index if fragment_exist?( "ratingstats" )
  end

	def expire_related_cache
		expire_fragment('ratingstats')
	end

  def index
    @ratings = Rating.all
		@top_breweries = Brewery.top 3
		@top_beers = Beer.top 3
		@top_raters = User.top_raters 3
		@latest_ratings = Rating.latest 5
		@top_styles = Style.top 3
  end

  def new
    @rating = Rating.new
		@beers = Beer.all
  end

  def create
		 @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
          redirect_to signin_path, notice:'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating  
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

	def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end

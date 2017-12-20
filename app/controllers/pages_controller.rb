class PagesController < ApplicationController

  def front
    redirect_to home_path if logged_in?
  end

  def home
    @recent_reviews = Review.recent_reviews
  end
end
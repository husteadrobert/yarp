class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.business = Business.find(params[:business_id])
    if @review.save
      flash[:message] = "Review Created Successfully"
      redirect_to business_path(@review.business)
    else
      flash[:danger] = "There was a problem"
      render 'businesses/show'
    end
  end

  private
    def review_params
      params.require(:review).permit!
    end
end
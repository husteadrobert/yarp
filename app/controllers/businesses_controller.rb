class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @businesses = Business.all.order('updated_at DESC, created_at DESC')
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(biz_params)
    if @business.save
      flash[:success] = "Business Created Successfully"
      redirect_to business_path(@business)
    else
      flash[:danger] = "Something went wrong"
      render 'new'
    end
  end

  def show
    @business = Business.find(params[:id])
  end

  private
    def biz_params
      params.require(:business).permit!
    end

end
class ReviewsController < ApplicationController
  def create
    @review = Review.create(review_params)
    @product = Product.find(params[:product_id])
    @review.product_id = @product.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to product_path(@product), notice: 'Review created!'
    else
      redirect_to new_session_path
    end
  end

  private
  def review_params
    params.require(:review).permit(:product_id,:description,:rating)
  end
end

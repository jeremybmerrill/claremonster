class UpvotesController < ApplicationController

  def create
    @wish = Wish.find(params[:wish_id])
   	@upvote = @wish.upvotes.create(params[:upvote])
   		 redirect_to wish_path(@wish)
  end
end
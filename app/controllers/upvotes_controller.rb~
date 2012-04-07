class UpvotesController < ApplicationController

  def create
    @wish = Wish.find(params[:wish_id])
   	if @upvote = @wish.upvotes.create(params[:upvote]).save
        redirect_to wish_path(@wish)
    else
    	redirect_to wish_path(@wish), notice: 'You must log in to upvote a wish.'
     end
  end
end
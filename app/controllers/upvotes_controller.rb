class UpvotesController < ApplicationController

  load_and_authorize_resource #cancan

  def create
    @wish = Wish.find(params[:wish_id])
    upvote = {}
    upvote[:user_id] = current_user.id
    upvote[:wish_id] = params[:wish_id]
   	if @upvote = @wish.upvotes.create(upvote).save
        redirect_to wish_path(@wish)
    else
    	redirect_to wish_path(@wish), notice: 'You must log in to upvote a wish.'
     end
  end
end

class CommentsController < ApplicationController

    load_and_authorize_resource #cancan

	def create
     	@wish = Wish.find(params[:wish_id])
   	 	@comment = @wish.comments.create(params[:comment])
   		 redirect_to wish_path(@wish)
  	end

  	def destroy
    	@wish = Wish.find(params[:wish_id])
    	@comment = @wish.comments.find(params[:id])
    	@comment.destroy
   	 	redirect_to wish_path(@wish)
 	 end

end

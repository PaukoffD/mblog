class CommentsController < ApplicationController
before_filter :find_post, only: [:show, :edit, :update, :destroy]

 def create
    @post = Post.find(params[:post_id])
	commenter= current_user.name 
    @comment = @post.comments.create(comment_params)
	
    redirect_to post_path(@post)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end

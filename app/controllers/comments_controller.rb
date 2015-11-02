class CommentsController < ApplicationController
before_filter :find_post, only: [:show, :edit, :update, :destroy]
def new
    @comment = comment.new
end



 def create
    @post = Post.friendly.find(params[:post_id])
	@comment = Comment.new  comment_params
	@comment.commenter= current_user.name 
    @post.comments << @comment
	
    redirect_to post_path(@post)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end

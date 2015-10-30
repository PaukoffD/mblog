class PostsController < ApplicationController
 before_filter :authenticate_user!, except: [:show, :index]
 before_filter :find_post, only: [:show, :edit, :update, :destroy]
 
 def index
 
 
 @posts = Post.order('created_at DESC').page(params[:page])
 end
 
 def show
  @post = Post.friendly.find(params[:id])
 end
	
def new
    @post = Post.new
end

def edit
   @post = Post.friendly.find(params[:id])
   
end


  def create
       @user = current_user       
	   @post = Post.new(allowed_params)

        if @post.save
            flash[:success] = "Created new post"
            redirect_to @post
        else
            render 'new'
        end
    end

   
		
def update
        @post = Post.friendly.find(params[:id])
        
            if @post.update_attributes(allowed_params)
                flash[:success] = "Updated post"
                redirect_to @post
            else
                render 'edit'
            end
end      

def destroy
        @post = Post.friendly.find(params[:id])
        if @post.user == current_user
            @post.destroy
            redirect_to posts_path
        else
            redirect_to root_path
            flash[:danger] = "You can't do this"
        end
    end

 private
        def allowed_params
            params.require(:post).permit(:title, :body, :user_id,:slug)
        end
		
		def find_post
        @post = Post.friendly.find(params[:id])
        end
end

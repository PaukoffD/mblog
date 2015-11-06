class PostsController < ApplicationController
 before_filter :authenticate_user!, except: [:show, :index]
 before_filter :find_post, only: [:show, :edit, :update, :destroy]
 
 def normalize_friendly_id(string)
    string.to_slug.normalize.to_s
end
 
 
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
         
	   @post = Post.new(allowed_params)
	   @post.slug= normalize_friendly_id(@post.title)
	   puts @post.slug
       @post.user_id=current_user.id 
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
            params.require(:post).permit(:title, :body, :user_id, :slug, :hidden)
        end
		
		def find_post
        @post = Post.friendly.find(params[:id])
		 #if request.path != post_path(@post)
        #return redirect_to @post, :status => :moved_permanently
        #end
        end
end

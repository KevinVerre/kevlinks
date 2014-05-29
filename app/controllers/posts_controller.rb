class PostsController < ApplicationController
  def index
    @posts = Post.where("private = 'f' OR user_id = ?", current_user).order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])

    # Do not show if this is a private post and this user is not the owner
    if (@post.private && (@post.user != current_user))
      redirect_to root_path
      return
    end

    if @post.ptype == LINK_TYPE || @post.ptype == TWEET_TYPE
      redirect_to @post.parent
    end

    @children = @post.children

    @new_post = Post.new
  end

  def new
    @post = Post.new
    @post.ptype = TWEET_TYPE
    @parent_id = params[:parent_id]
    @parent_post = Post.find(@parent_id)
    @parent_title = @parent_post.title

    # Do not show the new post page if not logged in or owner of parent
    if !current_user || current_user != @parent_post.user
      redirect_to @parent_post
    end
  end

  def create

    my_params = post_params
    @post = Post.new(my_params)
    @post.user = current_user

    p my_params
    p params

    if my_params[:parent_id]

      @parent_post = Post.find(my_params[:parent_id])
      if current_user && @parent_post.user == current_user

        PostChecker(@post)

        if @post.save
          redirect_to @post
          return
        else
          render :show
          return
        end
      end
    end

    #There was something wrong with the create
    redirect_to root_path

  end

  def edit
    @post = Post.find(params[:id])
    @parent_post = @post.parent

    # Do not show the edit page if not logged in or not the post's user
    if (!current_user || (current_user != @post.user))
      redirect_to root_path
      return
    end
  end

  def update
    @post = Post.find(params[:id])

    # Don't update a post if not logged in as the post's owner
    if !current_user || current_user != @post.user
      redirect_to root_path
      return
    end 

    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    puts "Attempting to delete"

    # user must be logged in to delete anything
    if current_user == @post.user
      puts "User is logged in and is the owner"
      parent_post = @post.parent

      # Must have a parent post, don't destroy a post if it doesn't have a parent.
      if parent_post
        if @post.destroy
          redirect_to parent_post
          return
        end
      end
    end

    render :show
  end

  def post_params
    params.require(:post).permit(:parent_id, :title, :body, :ptype, :private)
  end

  private

  def url_checker(inputString)
    resultingString = ""
    if !inputString.starts_with?("http://")
      resultingString = "http://" + inputString
    end
    resultingString
  end

  def PostChecker(p)
    if p.ptype == LINK_TYPE
      p.body = url_checker p.body
    end
  end

end

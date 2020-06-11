class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts = Post.all.order(id: :desc).page(params[:page]).per(10)
  end
  
  def followings
    @posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.build
  end

  def new
    if params[:game_id]
      @post = Post.new(game_id: params[:game_id])
    else
      @post = Post.new
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "ツイートを投稿しました。"
      redirect_to @post
    else
      flash.now[:danger] = "ツイートの投稿に失敗しました。"
      render new_post_path
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "ツイートを削除しました。"
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content,:image1,:image2, :game_id)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end

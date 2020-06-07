class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    current_user.likes(post)
    flash[:success] ="いいね！しました。"
    redirect_to post
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlikes(post)
    flash[:success] = "いいね！を解除しました。"
    redirect_to post
  end
end

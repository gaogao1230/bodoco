class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :current_user, only: [:destroy]
  
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = "コメントを投稿しました。"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "コメントの投稿に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user
    @comment = current_user.comment.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
    
end

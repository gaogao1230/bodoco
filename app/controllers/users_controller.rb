class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:index,:show,:edit,:update,:followings,:followers,:likeings]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(10)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザ情報を更新しました。"
      redirect_to @user
    else
      flash.now[:danger] = "保存に失敗しました。"
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(10)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(10)
    counts(@user)
  end
  
  def likeings
    @user = User.find(params[:id])
    @likeings = @user.likeings.page(params[:page]).per(10)
    counts(@user)
  end
  
  def games
    @user = User.find(params[:id])
    @games = @user.games.page(params[:page]).per(10)
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:profile,:image)
  end
end

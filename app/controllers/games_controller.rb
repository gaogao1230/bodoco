class GamesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @games_all = Game.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.build(game_params)
    if @game.save
      flash[:success] = "ゲームを投稿しました。"
      redirect_to root_url
    else
      @current_user.games.order(id: :desc).page(params[:page])
      flash.now[:danger] = "ゲームの投稿に失敗しました。"
      render :new
    end
  end

  def destroy
    @game.destroy
    flash[:success] = "ゲームを削除しました。"
    redirect_to(fallback_location: root_path)
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      flash[:success] = "ゲーム情報を更新しました。"
      redirect_to @game
    else
      flash.now[:danger] = "保存に失敗しました。"
      render :edit
    end
  end

  def edit
    @game = Game.find(params[:id])
  end
  
  def search
    if params[:name].present?
      @games = Game.where("name LIKE ?","%#{params[:name]}%")
    else
      @games = Game.none
    end
  end
  
  private
  
  def game_params
    params.require(:game).permit(:name,:play_people,:play_time,:content,:image)
  end
  
  def correct_user
    @game = current_user.games.find_by(id: params[:id])
    unless @game
      redirect_to root_url
    end
  end
end

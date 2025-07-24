class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show, :following, :followers]
  def show
    @tweets = @user.tweets.order(created_at: :desc)
  end
  def following
    @title = "Following"
    @users = @user.following
    if params[:search].present?
      @users = User.where("name LIKE ?", "%#{params[:search]}%").where.not(id: @user.id)
    end
    @users = @users.paginate(page: params[:page])
    render 'show_follow'
  end
  def followers
    @title = "Followers"
    @users = @user.followers
    if params[:search].present?
      @users = User.where("name LIKE ?", "%#{params[:search]}%").where.not(id: @user.id)
    end
    @users = @users.paginate(page: params[:page])
    render 'show_follow'
  end
  def index
    @users = User.all
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
end
class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:show, :search] # ログインしていないユーザーもプロフィールと検索は見れるように 
    before_action :set_user, only: [:show, :following, :followers]
 def show
    @user = User.find(params[:id]) 
    @tweets = @user.tweets.order(created_at: :desc)
  end
  def following 
    @title = "Following" 
    @users = @user.following.paginate(page: params[:page]) 
    render 'show_follow' 
end 
def followers 
    @title = "Followers" 
    @users = @user.followers.paginate(page: params[:page]) 
    render 'show_follow' 
end 
def search 
    @users = User.where('name LIKE ?', "%#{params[:q]}%").paginate(page: params[:page]) 
end 
private 
def set_user 
    @user = User.find(params[:id]) 
end
end

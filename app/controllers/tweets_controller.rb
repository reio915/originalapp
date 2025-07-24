class TweetsController < ApplicationController
before_action :authenticate_user!
def index
  @tweets = Tweet.all.page(params[:page])
end
def new
    @tweet = Tweet.new
end
def create
  @tweet = Tweet.new(tweet_params)
  @tweet.user_id = current_user.id
  if @tweet.save
    redirect_to user_path(current_user), notice: "投稿が完了しました"
  else
    render :new
  end
end
def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
end
def edit
    @tweet = Tweet.find(params[:id])
end
def update
  @tweet = Tweet.find(params[:id])
  if @tweet.update(tweet_params)
    redirect_to user_path(current_user), notice: "編集が完了しました"
  else
    render :edit
  end
end
def destroy
  @tweet = Tweet.find(params[:id])
  if @tweet.user == current_user
    @tweet.destroy
    redirect_to user_path(current_user), notice: "投稿を削除しました"
  else
    redirect_to tweets_path, alert: "削除できません"
  end
end

def search
  @tweets = Tweet.all
  search = params[:search]
  @tweets = @tweets.joins(:user).where("tweets.name LIKE ?", "%#{search}%") if search.present?
  tweets = Tweet.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
end
  private
def tweet_params
    params.require(:tweet).permit(:body,:overall,:taste,:atmosphere,:service,:photo, :image,:lat,:lng,:name)
end
end


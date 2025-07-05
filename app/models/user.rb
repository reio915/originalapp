class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        has_one_attached :image 
has_many :tweets, dependent: :destroy
validates :name, presence: true
validates :profile, length: { maximum: 200 }
has_many :likes, dependent: :destroy
has_many :liked_tweets, through: :likes, source: :tweet
has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy 
has_many :following, through: :active_relationships, source: :followed 
has_many :followers, through: :passive_relationships, source: :follower # ユーザーをフォローする 
has_many :comments, dependent: :destroy
def follow(other_user) 
 following << other_user unless self == other_user 
end # ユーザーのフォローを解除する 
def unfollow(other_user) 
  following.delete(other_user) 
end # 現在のユーザーがフォローしていればtrueを返す 
def following?(other_user) 
  following.include?(other_user) 
end # フォローしているユーザーのツイートと自分のツイートを取得する 
def feed 
  following_ids = "SELECT followed_id FROM relationships 
  WHERE follower_id = :user_id" 
  Tweet.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id) 
       .order(created_at: :desc) 
end
def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
end
end

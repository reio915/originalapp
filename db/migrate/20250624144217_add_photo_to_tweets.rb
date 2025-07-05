class AddPhotoToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :photo, :integer
  end
end

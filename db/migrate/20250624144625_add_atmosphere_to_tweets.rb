class AddAtmosphereToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :atmosphere, :integer
  end
end

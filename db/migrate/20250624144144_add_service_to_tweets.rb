class AddServiceToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :service, :integer
  end
end

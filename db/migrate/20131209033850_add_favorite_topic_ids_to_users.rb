class AddFavoriteTopicIdsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_topic_ids, :string
  end
end

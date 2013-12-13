class AddZanTopicIdsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zan_topic_ids, :string
  end
end

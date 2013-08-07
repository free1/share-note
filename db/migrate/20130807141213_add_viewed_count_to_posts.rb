class AddViewedCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :viewed_count, :integer
  end
end

class AddKindToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :kind, :string
  end
end

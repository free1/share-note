class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :website, :string
    add_column :users, :github, :string
    add_column :users, :twitter, :string
    add_column :users, :qq, :integer
    add_column :users, :city, :string
    add_column :users, :company, :string
    add_column :users, :position, :string
    add_column :users, :autograph, :string
    add_column :users, :resume, :text
  end
end

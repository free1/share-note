class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :kind
      t.string :language
      t.integer :post_id

      t.timestamps
    end
  end
end

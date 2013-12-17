class CreateQiandaos < ActiveRecord::Migration
  def change
    create_table :qiandaos do |t|
      t.date :qiandao_day_time
      t.integer :qiandao_day_count
      t.integer :user_id

      t.timestamps
    end
  end
end

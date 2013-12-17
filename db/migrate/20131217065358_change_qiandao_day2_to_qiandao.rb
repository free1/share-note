class ChangeQiandaoDay2ToQiandao < ActiveRecord::Migration
  def change
    change_column :qiandaos, :qiandao_day_time, :integer
  end
end

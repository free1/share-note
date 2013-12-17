class ChangeQiandaoDayTimeToQiandao < ActiveRecord::Migration
  def change
    change_column :qiandaos, :qiandao_day_time, :string
  end
end

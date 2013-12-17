class ChangeQiandaoDayTimeDefault3ToQiandao < ActiveRecord::Migration
  def change
    change_column_default :qiandaos, :qiandao_day_time, 0
  end
end

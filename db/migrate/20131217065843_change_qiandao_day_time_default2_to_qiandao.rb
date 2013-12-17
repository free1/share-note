class ChangeQiandaoDayTimeDefault2ToQiandao < ActiveRecord::Migration
  def change
    change_column_default :qiandaos, :qiandao_day_time, 1
  end
end

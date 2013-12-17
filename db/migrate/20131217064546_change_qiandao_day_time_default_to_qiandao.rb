class ChangeQiandaoDayTimeDefaultToQiandao < ActiveRecord::Migration
  def change
    change_column_default :qiandaos, :qiandao_day_time, ""
  end
end

class Qiandao < ActiveRecord::Base
  attr_accessible :qiandao_day_count, :qiandao_day_time

  belongs_to :user
end

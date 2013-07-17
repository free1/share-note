class Authentication < ActiveRecord::Base
	attr_accessible :provider, :uid

	validates :provider, :presence => true, :uniqueness => {:scope => :user_id}
	validates :uid, :presence => true, :uniqueness => {:scope => :provider}
	belongs_to :user

end

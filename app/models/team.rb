class Team < ActiveRecord::Base
	has_many :memberships
	has_many :users, :through => :memberships
	
	validates :teamname, :uniqueness => true
	
	

end

class Team < ActiveRecord::Base
	has_many :memberships, :limit => 4
	has_many :users, :through => :memberships
	
	validates :teamname, :uniqueness => true
	
	

end

class Team < ActiveRecord::Base
	has_many :memberships, :limit => 4
	has_many :users, :through => :memberships
	has_many :match_participations
	has_many :matches, :through => :match_participations
	
	
	validates :teamname, :uniqueness => true
	
	#return all Teams minus this one
	#might come back and filter out teams that this team is already playing against
	def get_opponents
		opponents = Team.all
		opponents.delete(self)
		opponents
	end
	
	#return all Users minus ones in this team
	def get_invitable_users
		invitable_users = User.all
		User.all.each do |u|
			if users.include?(u)
				invitable_users.delete(u)
			end
		end
		invitable_users
	end
	
	def has_full_team?
		users.size == 4
	end
	
	def has_matches_in_progress?
		matches.each do |m|
			if !m.team_winner_id
				true
			end
		end
	end
end

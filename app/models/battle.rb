class Battle < ActiveRecord::Base
	belongs_to :match
	
	has_many :battle_participations
	has_many :users, :through => :battle_participations
	
	
	def get_team_participants(a_team)
		participants_array = []
		users.each do |u|
			a_team.users.each do |team_user|
				if u==team_user
					participants_array << u.username
					break
				end
			end
		end
		participants_array
	end
	
	#get match.teams, return a string
	def get_all_participants
		participants_array = []
		match.teams.each do |t|
			participants_array << (get_team_participants(t).join)
		end
		participants_array
	end
	
	def team_winner_to_s
		team_winner_id ? Team.find(team_winner_id).teamname : "In Progress"
	end

end

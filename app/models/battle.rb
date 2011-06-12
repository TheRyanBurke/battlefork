class Battle < ActiveRecord::Base
	belongs_to :match
	
	has_many :battle_participations
	has_many :users, :through => :battle_participations
	
	
	def get_team_participants(a_team)
		participants_array = []
		users.each do |u|
			a_team.users.each do |team_user|
				if u==team_user
					participants_array << u
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
			participants_array << get_team_participants(t)
		end
		participants_array
	end
	
	def team_winner_to_s
		team_winner_id ? Team.find(team_winner_id).teamname : "In Progress"
	end
	
	def is_user_allowed_to_report_winner(a_user_id)
		if users.include?(User.find(a_user_id))
			return true
		end
		
		match.teams.each do |t|
			if t.captain_user_id == a_user_id
				return true
			end
		end
		
		false
	end
	
	def signal_match_of_battle_completion
		match.process_battle_completion(self)
	end

end

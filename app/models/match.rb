class Match < ActiveRecord::Base
	has_many :battles
	has_many :match_participations
	has_many :teams, :through => :match_participations
	
	
	def get_other_team(a_team_id)
		#look up teams, return the teamname of the one that doesn't match this id
		teams.where("team_id != ?", a_team_id).first
	end
	
	def winner(a_team_id)
		if team_winner_id
			team_winner_id==a_team_id ? "W" : "L" 
		else
			"In progress"
		end
	end
	
	def all_orders_submit?
		#if all battles.winner != nil, return true, else return false
		#true signifies start of new round
		#this should be checked each time a battle completes
	end
	
	def check_for_end_conditions
		#does each team own their capital (v1)
		#does each team have at least 1 player still in the match (v2)
		#if any conditions are false, then trigger match end and clean up
	end

end

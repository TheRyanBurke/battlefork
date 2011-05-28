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
		#if all team captains have given each of their players an order
		# return true
	end
	
	def all_battles_complete?
		#if all battles.winner != nil, return true, else return false
		#true signifies start of new round
		#this should be checked each time a battle completes
		battles.each do |b|
			if !b.team_winner_id
				return false
			end
		end
		true
	end
	
	def is_user_a_captain?(a_user_id)
		teams.each do |t|
			if t.captain_user_id == a_user_id
				return true
			end
		end
		false
	end
	
	def end_conditions_met?
		#does each team own their capital (v1)
		#does each team have at least 1 player still in the match (v2)
		#if any conditions are false, then trigger match end and clean up
	end
	
	def generate_battles
		#if match has no winner
		# and all existing match.battles are complete
		# make 4 new battles, assign 1 player from each team
	end
	
	def get_created_timestamp
		timestamp = created_at.getlocal
		return timestamp.strftime("%Y-%m-%d %I:%M %p ") + timestamp.zone
	end

end

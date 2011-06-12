class Match < ActiveRecord::Base
	has_many :battles, :dependent => :destroy
	has_many :match_participations
	has_many :teams, :through => :match_participations
	has_one :map
	
	has_many :user_locations
	has_many :users, :through => :user_locations
	
	#come back to this and look up :dependent => :destroy to see if it makes sense here
	
	
	def get_first_team
		teams.first
	end
	
	def get_other_team
		#look up teams, return the teamname of the one that doesn't match this id
		teams.where("team_id != ?", get_first_team.id).first
	end
	
	def winner(a_team_id)
		if team_winner_id
			team_winner_id==a_team_id ? "W" : "L" 
		else
			"In progress"
		end
	end
	
	def get_user_locations_for_team(a_team)
		ul_for_team = []
		
		Team.find(a_team.id).users.each do |u|			
			ul_for_team << user_locations.where("match_id == ? AND user_id == ?", id, u.id).first
		end
		ul_for_team
	end
	
	def get_homeworld_for_team(a_team)
		map.get_homeworld_for_team(a_team)
	end
	
	def all_orders_submit?
		if all_battles_complete?
			user_locations.each do |ul|
				if !ul.next_location
					return false
				end
			end
			return true
		end
		false		
	end
	
	def all_orders_submit_for_team?(a_team)
		a_team.users.each do |u|
			if !u.user_locations.where("match_id == ?", id).first.next_location
				return false
			end
		end
		true
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
	
	def is_user_a_captain_of_this_team?(a_user_id, a_team_id)
		if Team.find(a_team_id).captain_user_id == a_user_id
			return true
		end
		false
	end
	
	def does_user_have_next_location?(a_user)
		user_locations.where("user_id == ?", a_user.id).first.next_location
	end
	
	def end_conditions_met?
		#does each team own their capital (v1)
		#does each team have at least 1 player still in the match (v2)
		#if any conditions are true, then trigger match end and clean up
		teams.each do |t|
			planet = get_homeworld_for_team(t)
			if planet.owner_team_id != planet.homeworld
				#homeworld belongs to someone else, GG
				puts "GG!!!!!!!!!!!!!!!!!!!!!!!"
				return planet.owner_team_id
			end
		end
		false
	end
	
	def generate_battles
		map.locations.each do |l|
			if l.has_multiple_teams_present?
				battle = Battle.new
				battle.match_id = id
				battle.save
				
				l.get_all_users_here.each do |u|
					bp = BattleParticipation.new
					bp.battle_id = battle.id
					bp.user_id = u.id
					bp.save
				end
				
				l.owner_team_id = nil
				l.save
			elsif l.has_one_team_present?
				l.owner_team_id = l.has_one_team_present?
				l.save
			end
			
		end
	end
	
	def process_battle_completion(a_battle)
		#check end conditions
		if end_conditions_met?
			self.team_winner_id = end_conditions_met?
			self.save
			return true
		end
				
		
		a_battle.users.each do |u|
			user_team = u.get_team_for_match(self)
			user_loc = u.get_user_location_for_match(self)
			if user_team.id != a_battle.team_winner_id
				#move losers to homeworld				
				user_loc.location = get_homeworld_for_team(user_team)
				user_loc.save			
			else
				#mark location owner as winner team id
				user_loc.location.owner_team_id = a_battle.team_winner_id
				user_loc.location.save
			end			
		end		
	end
	
	def get_created_timestamp
		timestamp = created_at.getlocal
		return timestamp.strftime("%Y-%m-%d %I:%M %p ") + timestamp.zone
	end
	
	def get_updated_timestamp
		timestamp = updated_at.getlocal
		return timestamp.strftime("%Y-%m-%d %I:%M %p ") + timestamp.zone
	end
	
	def move_all_users_to_next_location
		user_locations.each do |ul|
			ul.location = ul.next_location
			ul.save
		end
		clear_all_next_locations
		
		#check end conditions
		if end_conditions_met?
			self.team_winner_id = end_conditions_met?
			self.save
			return true
		end
	end

	def clear_all_next_locations
		user_locations.each do |ul|
			ul.next_location = nil
			ul.save
		end
	end

	def destroy_all_match_participations
		match_participations.each do |mp|
			mp.destroy
		end
	end
	
	def destroy_all_user_locations
		user_locations.each do |ul|
			ul.destroy
		end
	end
end

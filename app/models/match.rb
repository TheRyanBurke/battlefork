class Match < ActiveRecord::Base
	has_many :battles
	has_many :match_participations
	has_many :teams, :through => :match_participations
	has_one :map
	
	has_many :user_locations
	has_many :users, :through => :user_locations
	
	#should have same :locations through :user_locations and :map
	
	
	def get_first_team
		teams.all.first
	end
	
	def get_other_team(a_team_id)
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
		team_result = teams.where("team_id == ?", a_team.id).first
		team_result.users.user_locations.where("match_id == ?", id)
	end
	
	def get_homeworld_for_team(a_team)
		map.get_homeworld_for_team(a_team)
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
		if !team_winner_id && all_battles_complete?
			@battle = Battle.new
			@battle.match_id = id
			@battle.save
			
			foo = teams.all.first
			bar = get_other_team(foo.id)
			logger.debug ("team1 id = " + foo.id.to_s)
			logger.debug ("team2 id = " + bar.id.to_s)
			
			@bp = BattleParticipation.new
			@bp.battle_id = @battle.id
			@bp.user_id = foo.users.first.id
			@bp.save
			
			@bp2 = BattleParticipation.new
			@bp2.battle_id = @battle.id
			@bp2.user_id = bar.users.first.id
			@bp2.save
		end
	end
	
	def get_created_timestamp
		timestamp = created_at.getlocal
		return timestamp.strftime("%Y-%m-%d %I:%M %p ") + timestamp.zone
	end


	private
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

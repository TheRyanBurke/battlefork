class MatchParticipation < ActiveRecord::Base
	belongs_to :match
	belongs_to :team
	
	
	def set_players_to_starting_locations
		homeworld = match.get_homeworld_for_team(team)
		match.get_user_locations_for_team(team).each do |ul|
			ul.location = homeworld
			ul.location.team_owner_id = team.id
			ul.save
		end			
	end
	
	def create_user_locations
		team.users.each do |u|
			ul = UserLocation.new
			ul.user_id = u.id
			ul.match_id = match.id
			ul.location_id = nil
			ul.save
		end
	end
	
end

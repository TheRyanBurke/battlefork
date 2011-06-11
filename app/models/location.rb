class Location < ActiveRecord::Base
	belongs_to :map
	
	has_many :location_links, :foreign_key => "origin_id"
	has_many :destinations, :through => :location_links
	has_many :inverse_location_links, :class_name => "LocationLink", :foreign_key => "destination_id"
	has_many :origins, :through => :inverse_location_links
	
	has_many :user_locations
	has_many :users, :through => :user_locations
	
	def get_all_connected_locations
		copy_of_self = self
		copy_of_self.name += " (stay)"
		
		all_locations = [copy_of_self]
		
		destinations.each do |d|
			all_locations << d
		end
		
		origins.each do |o|
			all_locations << o
		end
		
		all_locations
	end
	
	def has_multiple_teams_present?
		set_of_teams_here = []
		user_locations.where("match_id == ?", map.match.id).each do |ul|
			if !set_of_teams_here.include?(ul.user.get_team_for_match(map.match).id)
				set_of_teams_here << ul.user.get_team_for_match(map.match).id
			end
		end
		if set_of_teams_here.length > 1
			return set_of_teams_here
		else
			return false
		end
	end
	
	def has_one_team_present?
		set_of_teams_here = []
		user_locations.where("match_id == ?", map.match.id).each do |ul|
			if !set_of_teams_here.include?(ul.user.get_team_for_match(map.match).id)
				set_of_teams_here << ul.user.get_team_for_match(map.match).id
			end
		end
		if set_of_teams_here.length == 1
			return set_of_teams_here.first
		else
			return false
		end
	end
	
	def get_all_users_here
		set_of_users_here = []
		user_locations.where("match_id == ?", map.match.id).each do |ul|
			set_of_users_here << ul.user
		end
	end

end

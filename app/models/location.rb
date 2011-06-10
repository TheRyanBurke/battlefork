class Location < ActiveRecord::Base
	belongs_to :map
	
	has_many :location_links, :foreign_key => "origin_id"
	has_many :destinations, :through => :location_links
	has_many :inverse_location_links, :class_name => "LocationLink", :foreign_key => "destination_id"
	has_many :origins, :through => :inverse_location_links
	
	has_many :user_locations
	has_many :users, :through => :user_locations
	
	def get_all_connected_locations
		all_locations = [self]
		
		destinations.each do |d|
			all_locations << d
		end
		
		origins.each do |o|
			all_locations << o
		end
		
		all_locations
	end

end

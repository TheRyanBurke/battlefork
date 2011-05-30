class Location < ActiveRecord::Base
	belongs_to :map
	
	has_many :location_links, :foreign_key => "origin"
	has_many :destinations, :through => :location_links
	has_many :inverse_location_links, :class_name => "LocationLink", :foreign_key => "destination"
	has_many :origins, :through => :inverse_location_links
	
	has_many :user_locations
	has_many :users, :through => :user_locations

end

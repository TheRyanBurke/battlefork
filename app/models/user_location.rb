# This class is poorly named. It maps a User to a Location for a certain Match.
# At the least, it should be changed to UserMatchLocation
# It probably should be changed to a User-Match relationship which stores
#  all the relevant User-specific info about a Match, like the Team,
#  Location, next location via an order, etc.
class UserLocation < ActiveRecord::Base
	belongs_to :user
	belongs_to :location
	belongs_to :match
	belongs_to :next_location, :class_name => "Location"
end

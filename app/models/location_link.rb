class LocationLink < ActiveRecord::Base
	belongs_to :origin, :class_name => "Location"
	belongs_to :destination, :class_name => "Location"
end

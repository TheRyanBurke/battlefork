class AddNextLocationIdToUserLocation < ActiveRecord::Migration
  def self.up
    add_column :user_locations, :next_location_id, :integer
  end

  def self.down
    remove_column :user_locations, :next_location_id
  end
end

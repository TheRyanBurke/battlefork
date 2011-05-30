class AddUseridAndLocationidToUserLocation < ActiveRecord::Migration
  def self.up
    add_column :user_locations, :user_id, :integer
    add_column :user_locations, :location_id, :integer
  end

  def self.down
    remove_column :user_locations, :location_id
    remove_column :user_locations, :user_id
  end
end

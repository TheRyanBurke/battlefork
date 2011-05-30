class AddOriginAndDestinationToLocationLink < ActiveRecord::Migration
  def self.up
    add_column :location_links, :origin, :integer
    add_column :location_links, :destination, :integer
  end

  def self.down
    remove_column :location_links, :destination
    remove_column :location_links, :origin
  end
end

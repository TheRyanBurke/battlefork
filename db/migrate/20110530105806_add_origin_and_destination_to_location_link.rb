class AddOriginAndDestinationToLocationLink < ActiveRecord::Migration
  def self.up
    add_column :location_links, :origin_id, :integer
    add_column :location_links, :destination_id, :integer
  end

  def self.down
    remove_column :location_links, :destination_id
    remove_column :location_links, :origin_id
  end
end

class AddMatchIdToUserLocation < ActiveRecord::Migration
  def self.up
    add_column :user_locations, :match_id, :integer
  end

  def self.down
    remove_column :user_locations, :match_id
  end
end

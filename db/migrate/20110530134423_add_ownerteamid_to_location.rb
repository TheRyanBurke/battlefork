class AddOwnerteamidToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :owner_team_id, :integer
  end

  def self.down
    remove_column :locations, :owner_team_id
  end
end

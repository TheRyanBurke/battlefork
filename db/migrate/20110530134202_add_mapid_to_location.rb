class AddMapidToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :map_id, :integer
  end

  def self.down
    remove_column :locations, :map_id
  end
end

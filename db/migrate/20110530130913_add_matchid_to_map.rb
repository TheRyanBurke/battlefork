class AddMatchidToMap < ActiveRecord::Migration
  def self.up
    add_column :maps, :match_id, :integer
  end

  def self.down
    remove_column :maps, :match_id
  end
end

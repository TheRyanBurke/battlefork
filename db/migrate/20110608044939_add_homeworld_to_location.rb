class AddHomeworldToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :homeworld, :integer
  end

  def self.down
    remove_column :locations, :homeworld
  end
end

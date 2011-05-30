class CreateLocationLinks < ActiveRecord::Migration
  def self.up
    create_table :location_links do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :location_links
  end
end

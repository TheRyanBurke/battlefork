class CreateMatchParticipations < ActiveRecord::Migration
  def self.up
    create_table :match_participations do |t|
      t.integer :team_id
      t.integer :match_id

      t.timestamps
    end
  end

  def self.down
    drop_table :match_participations
  end
end

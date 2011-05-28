class CreateBattleParticipations < ActiveRecord::Migration
  def self.up
    create_table :battle_participations do |t|
      t.integer :user_id
      t.integer :battle_id

      t.timestamps
    end
  end

  def self.down
    drop_table :battle_participations
  end
end

class AddCaptainToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :captain_user_id, :integer
  end

  def self.down
    remove_column :teams, :captain_user_id
  end
end

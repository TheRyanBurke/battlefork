class AddTeamWinnerIdToBattle < ActiveRecord::Migration
  def self.up
    add_column :battles, :team_winner_id, :integer
  end

  def self.down
    remove_column :battles, :team_winner_id
  end
end

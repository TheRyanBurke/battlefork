class AddTeamWinnerIdToMatch < ActiveRecord::Migration
  def self.up
    add_column :matches, :team_winner_id, :integer
  end

  def self.down
    remove_column :matches, :team_winner_id
  end
end

class Battle < ActiveRecord::Base
	belongs_to :match
	
	has_many :battle_participations
	has_many :users, :through => :battle_participations
	
	
	def get_participants(a_team)
		participants_array = []
		users.each do |u|
			a_team.users.each do |team_user|
				if u==team_user
					participants_array << u.username
					break
				end
			end
		end
		participants_array.join
	end

end

class User < ActiveRecord::Base
	has_many :memberships
	has_many :teams, :through => :memberships
	
	has_many :battle_participations
	has_many :battles, :through => :battle_participations
	
	has_many :user_locations
	has_many :locations, :through => :user_locations
	
	validates :username, :presence => true, :uniqueness => true
	validates :password, :confirmation => true
	
	attr_accessor :password_confirmation
	attr_reader :password
	
	validate :password_must_be_present
	
	def User.encrypt_password(password, salt)
			Digest::SHA2.hexdigest(password + "wibble" + salt)
	end
	
	def password=(password)
		@password = password
		
		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end
	
	def User.authenticate(name, password)
		if user = User.where("username == ?", name).first
			if user.hashed_password == encrypt_password(password, user.salt)
				user
			end
		end
	end
	
	def get_team_for_match(a_match)
		teams.each do |t|
			if t.match_participations.where("match_id == ?", a_match.id).first
				return t
			end
		end
	end
	
	def get_user_location_for_match(a_match)
		UserLocation.where("match_id == ? AND user_id == ?", a_match.id, id).first.location
	end
	
	private
	
		def password_must_be_present
			errors.add(:password, "Missing password") unless hashed_password.present?
		end
		
		def generate_salt
			self.salt = self.object_id.to_s + rand.to_s
		end
		
		

end

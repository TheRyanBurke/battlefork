class Map < ActiveRecord::Base
	belongs_to :match
	has_many :locations	
	
	def get_homeworld_for_team(a_team)
		locations.each do |l|
			if l.homeworld
				if l.homeworld == a_team.id
					return l
				end
			end
		nil
	end
	
	#hard-coded locations, revisit this in v2
	# 
	# 8x8 grid, x is a planet, h is a capital
	#
	#  a  b  c  d  e  f  g  h
	#0 h-----x--------x-----x
	#  |     |      /  \    |
	#1 |      \    /    |   |
	#  |       \  /      \  |
	#2 |        x        x  |
	#  |      / |       / | |
	#3 x----  |  -----x   | |
	#  |\   \ |     /  \   \|
	#4 | |   x      |   ----x
	#  | |  /  \    /       |
	#5 | x--    ---x        |
	#  |  \       / \       |
	#6 |   \   ---   \      |
	#  |    | /       |     |
	#7 x----x---------x-----h
	def generate_locations
		a0 = Location.new
		a0.name = "alpha"
		a0.posx = 0
		a0.posy = 0
		a0.map_id = id
		a0.homeworld = match.get_first_team.id
		a0.save
		
		c0 = Location.new
		c0.name = "bravo"
		c0.posx = 0
		c0.posy = 2
		c0.map_id = id
		c0.save
		
		f0 = Location.new
		f0.name = "charlie"
		f0.posx = 0
		f0.posy = 5
		f0.map_id = id
		f0.save
		
		h0 = Location.new
		h0.name = "delta"
		h0.posx = 0
		h0.posy = 7
		h0.map_id = id
		h0.save
		
		d2 = Location.new
		d2.name = "echo"
		d2.posx = 2
		d2.posy = 3
		d2.map_id = id
		d2.save
		
		g2 = Location.new
		g2.name = "foxtrot"
		g2.posx = 2
		g2.posy = 6
		g2.map_id = id
		g2.save		
		
		a3 = Location.new
		a3.name = "golf"
		a3.posx = 3
		a3.posy = 0
		a3.map_id = id
		a3.save
		
		f3 = Location.new
		f3.name = "hotel"
		f3.posx = 3
		f3.posy = 5
		f3.map_id = id
		f3.save
		
		c4 = Location.new
		c4.name = "india"
		c4.posx = 4
		c4.posy = 2
		c4.map_id = id
		c4.save
		
		h4 = Location.new
		h4.name = "juliet"
		h4.posx = 4
		h4.posy = 7
		h4.map_id = id
		h4.save
		
		b5 = Location.new
		b5.name = "kilo"
		b5.posx = 5
		b5.posy = 1
		b5.map_id = id
		b5.save
		
		e5 = Location.new
		e5.name = "lima"
		e5.posx = 5
		e5.posy = 4
		e5.map_id = id
		e5.save
		
		a7 = Location.new
		a7.name = "mike"
		a7.posx = 7
		a7.posy = 0
		a7.map_id = id
		a7.save
		
		c7 = Location.new
		c7.name = "november"
		c7.posx = 7
		c7.posy = 2
		c7.map_id = id
		c7.save		
		
		f7 = Location.new
		f7.name = "oscar"
		f7.posx = 7
		f7.posy = 5
		f7.map_id = id
		f7.save
		
		h7 = Location.new
		h7.name = "papa"
		h7.posx = 7
		h7.posy = 7
		h7.map_id = id
		h7.homeworld = match.get_other_team.id
		h7.save
		
		a0c0 = LocationLink.new
		a0c0.origin = a0
		a0c0.destination = c0
		a0c0.save
		
		c0f0 = LocationLink.new
		c0f0.origin = c0
		c0f0.destination = f0
		c0f0.save
		
		f0h0 = LocationLink.new
		f0h0.origin = f0
		f0h0.destination = h0
		f0h0.save
		
		a0a3 = LocationLink.new
		a0a3.origin = a0
		a0a3.destination = a3
		a0a3.save
		
		c0d2 = LocationLink.new
		c0d2.origin = c0
		c0d2.destination = d2
		c0d2.save
		
		f0d2 = LocationLink.new
		f0d2.origin = f0
		f0d2.destination = d2
		f0d2.save
		
		f0g2 = LocationLink.new
		f0g2.origin = f0
		f0g2.destination = g2
		f0g2.save
		
		h0h4 = LocationLink.new
		h0h4.origin = h0
		h0h4.destination = h4
		h0h4.save
		
		g2h4 = LocationLink.new
		g2h4.origin = g2
		g2h4.destination = h4
		g2h4.save
		
		g2f3 = LocationLink.new
		g2f3.origin = g2
		g2f3.destination = f3
		g2f3.save
		
		d2f3 = LocationLink.new
		d2f3.origin = d2
		d2f3.destination = f3
		d2f3.save
		
		f3h4 = LocationLink.new
		f3h4.origin = f3
		f3h4.destination = h4
		f3h4.save
		
		f3e5 = LocationLink.new
		f3e5.origin = f3
		f3e5.destination = e5
		f3e5.save		
		
		d2c4 = LocationLink.new
		d2c4.origin = d2
		d2c4.destination = c4
		d2c4.save
		
		a3c4 = LocationLink.new
		a3c4.origin = a3
		a3c4.destination = c4
		a3c4.save
		
		a3b5 = LocationLink.new
		a3b5.origin = a3
		a3b5.destination = b5
		a3b5.save
		
		c4b5 = LocationLink.new
		c4b5.origin = c4
		c4b5.destination = b5
		c4b5.save
		
		c4e5 = LocationLink.new
		c4e5.origin = c4
		c4e5.destination = e5
		c4e5.save
		
		b5c7 = LocationLink.new
		b5c7.origin = b5
		b5c7.destination = c7
		b5c7.save
		
		e5c7 = LocationLink.new
		e5c7.origin = e5
		e5c7.destination = c7
		e5c7.save
		
		a3a7 = LocationLink.new
		a3a7.origin = a3
		a3a7.destination = a7
		a3a7.save
		
		a7c7 = LocationLink.new
		a7c7.origin = a7
		a7c7.destination = c7
		a7c7.save
		
		c7f7 = LocationLink.new
		c7f7.origin = c7
		c7f7.destination = f7
		c7f7.save
		
		e5f7 = LocationLink.new
		e5f7.origin = e5
		e5f7.destination = f7
		e5f7.save
		
		f7h7 = LocationLink.new
		f7h7.origin = f7
		f7h7.destination = h7
		f7h7.save
		
		h4h7 = LocationLink.new
		h4h7.origin = h4
		h4h7.destination = h7
		h4h7.save	
	end
	
	#ugly impl of the 8x8 map, revisit in v2
	#if element in map grid is nil, it's empty space, else it's a location
	def make_map_grid
		grid = [nil] * 64
		locations.each do |l|
			grid[8 * l.posx + l.posy] = l
		end
		grid
	end
end

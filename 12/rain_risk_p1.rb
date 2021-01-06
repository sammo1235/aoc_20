class RainRisk
	attr_accessor :sx, :sy, :bearing

	def initialize(file)
		@sx = 0 # e/w
		@sy = 0 # n/s
		@bearing = 90 # start facing east
		File.open(file, 'r').readlines.map {|c| nav(c.chomp) }
	end

	def nav(ins)
		op = ins.scan(/\D/)[0]
		q = ins.scan(/\d/).join.to_i
		case op
		when "N", "S", "E", "W", "F"
			move(q, op)
		when "R", "L"
			turn(q, op)
		end
	end

	def turn(q, dir)
		if dir == "R"
			self.bearing += q
			self.bearing -= 360 if self.bearing >= 360
		elsif dir == "L"
			self.bearing -= q
			self.bearing += 360 if self.bearing < 0
		end
	end

	def move(q, dir)
		dir = get_bearing if dir == "F"

		case dir
		when "N"
			self.sy += q
		when "S"
			self.sy -= q
		when "E"
			self.sx += q
		when "W"
			self.sx -= q
		end
	end

	def get_bearing
		case bearing
		when 0
			"N"
		when 180
			"S"
		when 90
			"E"
		when 270
			"W"
		end
	end

	def man_dist
		sx.abs + sy.abs
	end
end


p RainRisk.new('./data2.txt').man_dist


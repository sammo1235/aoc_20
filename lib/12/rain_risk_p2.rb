require 'byebug'
class RainRisk
	attr_accessor :sx, :sy, :wx, :wy

	def initialize(file)
		@sx = 0
		@sy = 0
		@wx = 10
		@wy = 1
		File.open(file, 'r').readlines.map {|c| nav(c.chomp) }
	end

	def nav(ins)
		op = ins.scan(/\D/)[0]
		q = ins.scan(/\d/).join.to_i
		case op
		when "N", "S", "E", "W"
			move_wm(q, op)
		when "F"
			move_ship(q)
		when "R", "L"
			turn_wm(op, q)
		end
	end

	def turn_wm(dir, q)
		right = Proc.new {
			self.wx, self.wy = wy, -wx
		}
		left = Proc.new {
			self.wx, self.wy = -wy, wx
		}
		around = Proc.new {
			self.wx, self.wy = -wx, -wy
		}
		if q == 180
			around.call
		elsif dir == "R"
			q == 90 ? right.call : left.call
		else
			q == 90 ? left.call : right.call
		end
	end

	def move_ship(q)
		self.sx += wx * q
		self.sy += wy * q
	end

	def move_wm(q, dir)
		case dir
		when "N"
			self.wy += q
		when "S"
			self.wy -= q
		when "E"
			self.wx += q
		when "W"
			self.wx -= q
		end
	end

	def man_dist
		sx.abs + sy.abs
	end
end


p RainRisk.new('./data2.txt').man_dist

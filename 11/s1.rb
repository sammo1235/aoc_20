require 'byebug'

class Seats
	attr_accessor :input, :second_rule
	def initialize(second_rule=false)
		@input = File.open('./data2.txt', 'r').readlines.map {|l| l.chomp }
		@second_rule = second_rule
	end

	def modify
		copy = []
		input.size.times do |_|
			copy << Array.new
		end
		self.input.each_with_index do |ln, lx|
			(0..ln.size-1).each do |index|
				li = if index == 0
					0
				else
					index - 1
				end
				ui = if index == ln.size-1
					index
				else
					index + 1
				end

				lx == 0 ? lower = 0 : lower = lx -1
				lx == self.input.size-1 ? upper = lx : upper = lx + 1

				if ln[index]== 'L'
					if second_rule
						if seats_visible(lx, index) == 0
							copy[lx][index] = '#'
						else
							copy[lx][index] = 'L'
						end
					else
						if self.input[lower..upper].map {|b| b[li..ui]}.flatten.join.count('#') == 0
							copy[lx][index] = '#'
						else
							copy[lx][index] = 'L'
						end
					end
				elsif ln[index] == '#'
					if second_rule
						if seats_visible(lx, index) >= 5
							copy[lx][index] = 'L'
						else
							copy[lx][index] = '#'
						end
					else
						if self.input[lower..upper].map {|b| b[li..ui]}.flatten.join.count('#') > 4
							copy[lx][index] = 'L'
						else
							copy[lx][index] = '#'
						end
					end
				elsif ln[index] == '.'
					copy[lx][index] = '.'
				end
			end
		end
		self.input = copy
	end

	def seats_visible(line_index, index)
		left = index - 1
		occ = 0

		# left
		if index > 0
			left.downto(0).each do |ind|
				if input[line_index][ind] == 'L'
					break
				elsif input[line_index][ind] == '#'
					occ += 1
					break
				end
			end
		end

		# up left diag
		if index > 0
			b = line_index - 1
			left.downto(0).each do |ci|
				break if b < 0
				if input[b][ci] == 'L'
					break
				elsif input[b][ci] == '#'
					occ += 1
					break
				end
				b -= 1
			end
		end

		# up
		if line_index > 0
			up = line_index - 1
			up.downto(0).each do |ri|
			        if input[ri][index] == 'L'
				       break
				elsif input[ri][index] == '#'
		    			occ += 1
					break
				end
			end
		end

		# right up diagonal
		if index < input[0].size-1
			c = line_index - 1
			(index+1..input[0].size-1).each do |ri|
				break if c < 0
				if input[c][ri] == 'L'
					break
				elsif input[c][ri] == '#'
					occ += 1
					break
				end
				c -= 1
			end
		end

		# right
		if index < input[0].size-1
			(index+1..input[0].size-1).each do |ci|
				if input[line_index][ci] == 'L'
					break
				elsif input[line_index][ci] == '#'
					occ += 1
					break
				end
			end
		end

		# right down diag
		if index < input[0].size-1
			if line_index < input.size-1
				d = line_index + 1
				(index+1..input[0].size-1).each do |ci|
					break if d > input.size-1
					if input[d][ci] == 'L'
						break
					elsif input[d][ci] == '#'
						occ += 1
						break
					end
					d += 1
				end
			end
		end

		# down
		if line_index < input.size-1
			(line_index+1..input.size-1).each do |ri|
				if input[ri][index] == 'L'
					break
				elsif input[ri][index] == '#'
					occ += 1
					break
				end
			end
		end

		# down left diag
		if line_index < input.size - 1
			if index > 0
				e = line_index + 1
				f = index - 1
				f.downto(0).each do |ci|
					break if e > input.size-1
					if input[e][ci] == 'L'
						break
					elsif input[e][ci] == '#'
						occ += 1
						break
					end
					e += 1
				end
			end
		end

		occ
	end
end

# set second part of puzzle ruling true or false
s = Seats.new(true)
while true
	s.modify
	a = s.input
	pp a
	s.modify
	print "\n"
	b = s.input
	pp b
	print "\n"
	if a == b
		p b.flatten.join.count('#')
		break
	end
end

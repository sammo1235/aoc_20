class Seats
	attr_accessor :input
	attr_reader :row, :col, :diag

	def initialize(file)
		@input = File.open(file, 'r').readlines.map {|i| i.chomp }
		@row = @input.size
		@col = @input[0].size
		@diag = [-1, 0, 1]
	end

	def solve(part_one = true)
		while true
			copy = Array.new(row) { [] }
			change = false
			for r in (0...row)
				for c in (0...col)
					nocc = 0
					for dr in diag
						for dc in diag
									unless dr == 0 && dc == 0
										rr = r+dr
										cc = c+dc
										unless part_one
											while 0<=rr && rr<row && 0<=cc && cc<col && input[rr][cc] == '.'
												rr = rr+dr
												cc = cc+dc
											end
										end
										if 0<=rr && rr<row && 0<=cc && cc<col && input[rr][cc] == '#'
											nocc += 1
										end
									end
						end
					end

					max_visible = if part_one
						4
					else
						5
					end

					if self.input[r][c] == 'L' && nocc == 0
						copy[r][c] = '#'
						change = true
					elsif self.input[r][c] == '#' && nocc>=max_visible
						copy[r][c] = 'L'
						change = true
					else
						copy[r][c] = self.input[r][c]
					end
				end
			end

			if change
				self.input = copy
			else
				break
			end
		end

		count = 0
		for r in (0...row)
			for c in (0...col)
				if self.input[r][c] == '#'
					count += 1
				end
			end
		end
		count
	end
end


p Seats.new('./data.txt').solve # 2108
p Seats.new('./data.txt').solve(false) # 1897

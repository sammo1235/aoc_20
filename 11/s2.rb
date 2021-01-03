require 'byebug'
input = File.open('./data.txt', 'r').readlines.map {|i| i.chomp }
R = input.size
C = input[0].size
DX = [-1, 0, 1]

def solve(input, part_one)
	while true	
		copy = Array.new(R) { [] }
		change = false
		for r in (0...R)
			for c in (0...C)
				nocc = 0
				for dr in DX
					for dc in DX
					       unless dr == 0 && dc == 0	
						       rr = r+dr
						       cc = c+dc
						       unless part_one
							       while 0<=rr && rr<R && 0<=cc && cc<C && input[rr][cc] == '.'
								       rr = rr+dr
								       cc = cc+dc
							       end
						       end
						       if 0<=rr && rr<R && 0<=cc && cc<C && input[rr][cc] == '#'
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

				if input[r][c] == 'L' && nocc == 0
					copy[r][c] = '#'
					change = true
				elsif input[r][c] == '#' && nocc>=max_visible
					copy[r][c] = 'L'
					change = true
				else
					copy[r][c] = input[r][c]
				end
			end
		end

		if change
			input = copy
		else
			break
		end
	end

	count = 0
	for r in (0...R)
		for c in (0...C)
			if input[r][c] == '#'
				count += 1
			end
		end
	end
	count
end

p solve(input, true)
p solve(input, false)

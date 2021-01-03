class Jolt
	attr_accessor :input, :dp
	def initialize(input)
		@input = input
		@dp = {}
	end

	def solve(n)
		if dp[n]
			return dp[n]
		end

		if n == input.size - 1
			return 1
		end
		
		ans = 0
		(n+1..input.size-1).each do |i|
			if input[i]-input[n] <= 3
				ans += solve(i)
			end
		end
		dp[n] = ans
		ans			
	end
end
input = File.open('./data2.txt', 'r').readlines.map {|i| i.chomp.to_i }
input << 0
input.sort!
input << input.max+3
p Jolt.new(input).solve(0)


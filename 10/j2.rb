class Jolt
	attr_accessor :dp, :ip # input
	def initialize(file)
		@dp = {}
		@ip = File.open(file, 'r').readlines.map {|i| i.chomp.to_i }
		@ip << 0
		@ip.sort!
		@ip << @ip.max+3
	end

	def solve(index)
		if index == ip.size-1
			return 1
		end

		if dp[index]
			return dp[index]
		end
		
		ans = 0
		(index+1...ip.size).each do |j|
			if ip[j]-ip[index] <= 3
				ans += solve(j)
			end
		end
		
		dp[index] = ans
		ans
	end
end

p Jolt.new('./data3.txt').solve(0)

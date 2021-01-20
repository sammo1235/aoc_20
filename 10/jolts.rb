require 'byebug'
$input = File.open('./data.txt', 'r').readlines.map {|c| c.chomp.to_i }

one_count = 0
three_count = 0
$input << 0
$input.sort!
$input << $input.last + 3

$DP = {}
def dp(ind)
  if ind==$input.size-1
    return 1
  end
  if $DP[ind]
    return $DP[ind]
  end
  ans = 0
  (ind+1...$input.size).each do |j|
    if $input[j]-$input[ind]<=3
      ans += dp(j)
    end
  end
  $DP[ind] = ans
  return ans
end

p dp(0)

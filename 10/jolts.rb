require 'byebug'
$input = File.open('./data.txt', 'r').readlines.map {|c| c.chomp.to_i }
# input = [0, 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
#   32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 48, 49, 52]
one_count = 0
three_count = 0
$input << 0
$input.sort!
$input << $input.last + 3
# $input.each_with_index do |adp, i|
#   if adp == input.last
#     break
#   end
#   # debugger
#   if input[i+1] - adp == 1
#     one_count += 1
#   elsif input[i+1] - adp == 3
#     three_count += 1
#   end
# end

# p one_count * three_count

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

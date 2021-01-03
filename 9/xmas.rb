input = File.open("./data.txt", 'r').readlines
codes = []
input.each { |c| codes << c.chomp.to_i }

codes.each_with_index do |code, index|
  if index < 25
    next
  end
  do_break = false
  found = false
  codes[index-25..index-1].each do |thing|
    break if do_break
    codes[index-25..index-1].each do |thing2|
      if thing + thing2 == code
        do_break = true
        found = true
        break
      end
    end
  end
  p code, "none found" unless found
end

(1..100).each do |range|
  codes.each_with_index do |code, index|
    if codes[index..index+range].reduce(:+) == 69316178
      arr = codes[index..index+range]
      p arr.min + arr.max
      return
    end
  end
end
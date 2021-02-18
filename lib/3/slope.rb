def traverse_slope(drop, skip=false)
  file = File.open("./data.txt", 'r').readlines
  slope = []
  file.each do |line|
    slope << line.chomp * 120
  end

  trees_hit = 0
  position = 0
  slope.each_with_index do |row, index|
    if skip && index.odd?
      next
    end

    puts row, position, row[position], index, "\n"
    if row[position] == "#"
      trees_hit += 1
    end
    position += drop
    # if position > row.size
    #   position -= 28
    # end
  end
  trees_hit
end

a = traverse_slope(1)
b = traverse_slope(3)
c = traverse_slope(5)
d = traverse_slope(7)
e = traverse_slope(1, true)
f = a*b*c*d*e
p f
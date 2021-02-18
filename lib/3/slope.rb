class Slope
  attr_reader :file
  def initialize
    @file = File.open("./lib/3/data.txt", 'r').readlines
  end

  def part_one
    traverse_slope(3)
  end

  def part_two
    a = traverse_slope(1)
    b = traverse_slope(3)
    c = traverse_slope(5)
    d = traverse_slope(7)
    e = traverse_slope(1, true)
    f = a*b*c*d*e
    p f
  end

  def traverse_slope(drop, skip=false)
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

      if row[position] == "#"
        trees_hit += 1
      end
      position += drop
    end
    trees_hit
  end
end

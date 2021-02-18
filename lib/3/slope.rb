class Slope
  attr_reader :slope
  def initialize
    file = File.open("./lib/3/data.txt", 'r').readlines
    @slope = []
    file.each do |line|
      @slope << line.chomp * 120
    end
  end

  def part_one
    traverse_slope(3)
  end

  def part_two
    ([1, 3, 5, 7].map {|jump| traverse_slope(jump) } << traverse_slope(1, true)).reduce(:*)
  end

  def traverse_slope(drop, skip=false)
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

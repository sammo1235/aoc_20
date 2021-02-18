class ReportRepair
  def initialize
    @file = File.open('./lib/1/data.txt', 'r').readlines.map(&:to_i)
  end

  def part_one
    @file.each do |num1|
      if @file.include? 2020 - num1
        return num1 * (2020 - num1)
      end
    end
  end

  def part_two
    @file.each do |num1|
      @file.each do |num2|
        if @file.include?(2020 - num1 - num2)
          return num1 * num2 * (2020 - num1 - num2)
        end
      end
    end
  end
end

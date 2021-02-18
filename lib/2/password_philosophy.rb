class Password
  attr_reader :file
  def initialize
    @file = File.open('./lib/2/data.txt', 'r').readlines
  end

  def part_one
    count = 0

    file.each do |line|
      rule = line.split(':').first
      letter = rule.split(" ").last
      low_freq = rule.split(" ").first.split('-').first.to_i
      high_freq = rule.split(" ").first.split('-').last.to_i
      password = line.split(': ').last.chomp.split('')

      letter_count = password.count(letter)

      count += 1 if letter_count >= low_freq && letter_count <= high_freq
    end
    count
  end

  def part_two
    count = 0
    file.each do |line|
      rule = line.split(':').first
      letter = rule.split(" ").last
      low_pos = rule.split(" ").first.split('-').first.to_i
      high_pos = rule.split(" ").first.split('-').last.to_i
      password = line.split(': ').last.chomp.split('')

      positional_count = []
      positional_count << (password[low_pos-1] == letter)
      positional_count << (password[high_pos-1] == letter)

      count += 1 if positional_count.count(true) == 1
    end
    count
  end
end  

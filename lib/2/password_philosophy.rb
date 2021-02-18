class Password
  attr_reader :file
  def initialize
    @file = File.open('./lib/2/data.txt', 'r').readlines
  end

  def part_one
    check_passwords(true)
  end

  def part_two
    check_passwords(false)
  end
  
  def check_passwords(p_one)
    count = 0

    file.each do |line|
      rule = line.split(':').first
      letter = rule.split(" ").last
      low = rule.split(" ").first.split('-').first.to_i
      high = rule.split(" ").first.split('-').last.to_i
      password = line.split(': ').last.chomp.split('')

      if p_one
        letter_count = password.count(letter)

        count += 1 if letter_count >= low && letter_count <= high
      else
        positional_count = []
        positional_count << (password[low-1] == letter)
        positional_count << (password[high-1] == letter)
  
        count += 1 if positional_count.count(true) == 1
      end  
    end
    count
  end
end  

def password_checker
  file = File.open('./data.txt', 'r').readlines
  count = 0
  file.each do |line|
    rule = line.split(':').first
    letter = rule.split(" ").last
    low_freq = rule.split(" ").first.split('-').first.to_i
    high_freq = rule.split(" ").first.split('-').last.to_i
    password = line.split(': ').last.chomp.split('')
    p rule, letter, low_freq, high_freq, password
    # letter_count = password.split('').count(letter)
    # p letter_count
    positional_count = []
    positional_count << (password[low_freq-1] == letter)
    positional_count << (password[high_freq-1] == letter)
    p positional_count
    if positional_count.count(true) == 1
      count += 1
      puts "valid"
    end
    # if letter_count >= low_freq && letter_count <= high_freq
    #   count += 1
    #   p "valid"
    # else
    #   p "invalid"
    # end
    print "\n"
  end
  count
end

p password_checker
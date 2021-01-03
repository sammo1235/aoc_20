def find_sum_and_multiply
  file = File.open("./data.txt", 'r').readlines
  file.each do |line|
    line = line.to_i
    file.each do |num|
      num = num.to_i
      file.each do |num2|
        num2 = num2.to_i
        if line + num + num2 == 2020
          puts line, num, num2
          puts line * num * num2
          break
        end
      end
    end
  end
end

find_sum_and_multiply
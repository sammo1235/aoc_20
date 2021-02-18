VALID1 = ["byr", "cid", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"].freeze
VALID2 = ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"].freeze
def passport
  file = File.open("./data.txt", 'r').readlines
  passports = {}
  count = 0
  file.each do |line|
    if line != "\n"
      if passports[count]
        if line.split(' ').size > 1
          line.split(' ').each {|l| passports[count] << l }
        else
          passports[count] << line.chomp
        end
      else
        if line.split(' ').size > 1
          line.split(' ').each_with_index do |l, i|
            if i == 0
              passports[count] = [l]
            else
              passports[count] << l
            end
          end
        else
          passports[count] = [line.chomp]
        end
      end
    else
      count += 1
    end
  end
  valid = 0
  passports.each do |k, v|
    codes = v.map {|el| el.split(":").first }
    if codes.sort == VALID1 || codes.sort == VALID2
      all_good = true
      v.each do |dp|
        att = dp.split(":").first
        val = dp.split(":").last
        if att == "byr"
          if val.to_i >= 1920 && val.to_i <= 2002
            # p "valid: #{att}, #{val}"
          else
            # p "invalid: #{att}, #{val}"
            all_good = false
          end
        elsif att == "iyr"
          if val.to_i >= 2010 && val.to_i <= 2020
            # p "valid: #{att}, #{val}"
          else
            # p "invalid: #{att}, #{val}"
            all_good = false
          end
        elsif att == "eyr"
          if val.to_i >= 2020 && val.to_i <= 2030
            # p "valid: #{att}, #{val}"
          else
            all_good = false
            # p "invalid: #{att}, #{val}"
          end
        elsif att == "hgt"
          num = val.scan(/\d/).join.to_i
          measure = val.scan(/\D/).join
          if measure == "cm"
            if num >= 150 && num <= 193
              # p "valid: #{att}, #{val}"
            else
              all_good = false
              # p "invalid: #{att}, #{val}"
            end
          elsif measure == "in"
            if num >= 59 && num <= 76
              # p "valid: #{att}, #{val}"
            else
              # p "invalid: #{att}, #{val}"
              all_good = false
            end
          elsif measure == ''
            all_good = false
            # p "invalid #{att}, #{val}"
          end
        elsif att == "hcl"
          if !val.match?(/^#[0-9a-f]{6}$/)
            # p "invalid: #{att}, #{val}"
            all_good = false
          else
            # p "valid: #{att}, #{val}"
          end
        elsif att == "ecl"
          colours = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
          if !colours.include?(val)
            # p "invalid: #{att}, #{val}"
            all_good = false
          else
            # p "valid: #{att}, #{val}"
          end
        elsif att == "pid"
          if !val.match?(/^[0-9]{9}$/)
            # p "invalid: #{att}, #{val}"
            all_good = false
          else
            # p "valid: #{att}, #{val}"
          end
        else
          # p "cid"
        end
      end
      if all_good
        # p "valid pp: #{v}"
        valid += 1
      else
        # p "invalid pp: #{v}"
      end
    end
  end
  valid
end

p passport
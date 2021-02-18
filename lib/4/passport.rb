require 'byebug'
class Passport
  VALID1 = ["byr", "cid", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"].freeze
  VALID2 = ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"].freeze

  attr_accessor :passports

  def initialize
    data = File.open("./lib/4/data.txt", 'r').readlines
    @passports = get_passports(data)
  end

  def part_one
    validate
  end

  def part_two
    validate(false)
  end

  def get_passports(data)
    count = 0
    data.each_with_object(Hash.new {|h, k| h[k] = []}) do |line, hash| 
      line == "\n" ? count += 1 : line.split(' ').each {|l| hash[count] << l.chomp }
    end
  end

  def validate(p1 = true) 
    valid_count = 0
    passports.each do |_, values|
      codes = values.map {|el| el.split(":").first }.sort
      if codes == VALID1 || codes == VALID2
        if p1
          valid_count += 1
          next
        else
          valid_count += 1 if extra_rules(values)
        end
      end
    end
    valid_count
  end

  def extra_rules(values)
    values.each do |dp|
      att = dp.split(":").first
      val = dp.split(":").last
      if att == "byr"
        return false if val.to_i < 1920 || val.to_i > 2002
      elsif att == "iyr"
        return false if val.to_i < 2010 || val.to_i > 2020
      elsif att == "eyr"
        return false if val.to_i < 2020 || val.to_i > 2030
      elsif att == "hgt"
        num = val.scan(/\d/).join.to_i
        measure = val.scan(/\D/).join
        if measure == "cm"
          return false if num < 150 || num > 193
        elsif measure == "in"
          return false if num < 59 || num > 76
        elsif measure == ''
          return false
        end
      elsif att == "hcl"
        return false if !val.match?(/^#[0-9a-f]{6}$/)
      elsif att == "ecl"
        colours = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
        return false if !colours.include?(val)
      elsif att == "pid"
        return false if !val.match?(/^[0-9]{9}$/)
      end
    end
    true
  end
end

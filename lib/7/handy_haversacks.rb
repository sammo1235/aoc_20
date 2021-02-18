class HandyHaversacks
  attr_reader :input

  def initialize
    @input = File.open('./lib/7/data.txt', 'r').readlines
  end
  
  def part_one
    holds_gold = []

    input.each do |line|
      bag_types = line.split('contain')
      if bag_types.last.match?(/shiny gold bag/)
        holds_gold << bag_types.first.gsub(" bags ", "")
      end
    end

    while true
      new_holds = []
      input.each do |line|
        bag_types = line.split('contain')
        holds_gold.each do |bag|
          if bag_types.last.match?(/#{bag}/)
            new_bag = bag_types.first.gsub(" bags ", "")
            new_holds << new_bag unless holds_gold.include? new_bag
          end
        end
      end
      break if new_holds.empty?
      holds_gold << new_holds
      holds_gold.flatten!.uniq!
    end
    (holds_gold + new_holds).uniq.size
  end

  def part_two
    # find gold bag
    found = []
    input.each do |line|
      if line.split('contain').first.match?(/shiny gold bag/)
        line.split('contain').last.split(',').each do |bag|
          quantity = bag.scan(/\d/).join.to_i
          name = bag.split(' ')[1..-2].join(' ')
          found << [quantity, name, []]
        end
      end
    end

    def find_all_bags(input, bag)
      input.each do |line|
        if line.split('contain').first.match?(/#{bag}/)
          new_bags = []
          line.split('contain').last.split(',').each do |b|
            quantity = b.scan(/\d/).join.to_i
            name = b.split(' ')[1..-2].join(' ')
            if name == "other"
              return [0]
            else
              new_bags << [quantity, name, find_all_bags(input, name)]
            end
          end
        else
          next
        end
        return new_bags
      end
    end

    found.each do |data|
      data[2] = find_all_bags(input, data[1])
    end

    found.reduce(0) do |memo, level|
      memo += find_total(level)
      memo
    end
  end

  def find_total(level)
    if level[2] == [0] # contains no other bags, return self
      return level[0]
    else
      res = level[2].reduce(0) do |memo, inner|
        memo += level[0] * find_total(inner)
        memo
      end
      return level[0] + res
    end
  end
end
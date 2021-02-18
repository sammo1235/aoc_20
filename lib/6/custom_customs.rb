class CustomCustoms
  def initialize
    @input = File.open("./lib/6/data.txt", 'r').readlines
  end

  def part_one
    sort_groups.map { |k, group| group.join.split('').uniq.size }.reduce(:+)
  end

  def part_two
    all = 0
    sort_groups.each do |group, answers|
      answers[0].each do |question|
        all += 1 if answers.join.count(question) == answers.size
      end
    end
    all
  end

  private 

  def sort_groups
    group = 0
    @input.each_with_object(Hash.new {|h, k| h[k] = []}) do |ans, groups|
      if ans == "\n"
        group += 1
        next
      end
      groups[group] << ans.chomp.split('')
    end
  end
end
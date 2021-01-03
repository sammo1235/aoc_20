def answered
  input = File.open("./data.txt", 'r').readlines
  groups = {}
  group = 0
  input.each do |ans|
    if ans == "\n"
      group += 1
      next
    end
    if groups[group]
      groups[group] << ans.chomp.split('')
    else
      groups[group] = [ans.chomp.split('')]
    end
  end
  # groups.map do |k, group|
  #   group.join.split('').uniq.size
  # end.reduce(:+)
  # p groups
  all = 0
  groups.each do |group, answers|
    all_yes = 0
    answers[0].each do |question|
      if answers.join.count(question) == answers.size
        all_yes += 1
      end
    end
    all += all_yes
  end
  all
end

p answered
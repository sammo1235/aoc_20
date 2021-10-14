class ShuttleSearch
  attr_reader :earliest_time, :buses, :times

  def initialize(file)
    data = File.open(file, 'r').readlines.map {|c| c.chomp }
    @earliest_time = data.first.to_i
    @buses = data.last.split(",").select {|bus| bus != "x"}.map(&:to_i)
    @times = bus_times
  end

  def bus_times
    times = {}
    buses.each do |b|
      t = [0]
      100000.times do |n|
        t << t[n] + b
      end
      times[b] = t
    end
    times
  end

  def solve_part_1
    waits = {}
    times.each do |t|
      a = (t.last << earliest_time).sort
      idx = a.index(earliest_time)
      next_bus = a[idx+1]
      waits[t.first] = next_bus - earliest_time
    end

    waits.sort_by {|k, v| v}.first.inject(:*)
  end

  def solve_part_2

  end
end

p ShuttleSearch.new('./data.txt').solve_part_1
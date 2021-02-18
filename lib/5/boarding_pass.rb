class BoardingPass
  def initialize
    @input = File.open('./lib/5/data.txt').readlines
  end

  def part_one
    sort_seats.values.max
  end

  def part_two
    seats = (53..896).to_a
    tickets = sort_seats.sort_by {|k, v| v}.map {|el|el[1]}
    (seats - tickets)[0]
  end

  def sort_seats
    seats = {}
    @input.each_with_index do |pass, person|
      rows = (0..127).to_a
      cols = (0..8).to_a
      pass.chomp.split('').each_with_index do |letter, index|
        if index <= 6
          if letter == 'F' # front
            rows = rows[0..rows.length/2-1]
          elsif letter == 'B' # back
            rows = rows[rows.length/2..-1]
          end
        elsif index > 6
          if letter == 'L' # left 
            cols = cols[0..cols.length/2-1]
          elsif letter == 'R' # right
            cols = cols[cols.length/2..-1]
          end
        end
      end
      seats[person] = rows[0]*8 + cols[0]
    end
    seats
  end
end

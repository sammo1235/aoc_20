def bpass
  input = File.open('./data.txt').readlines
  # input = ["FBFBBFFRLR", "BFFFBBFRRR", "FFFBBBFRRR", "BBFFBBFRLL"]
  seats = {}
  input.each_with_index do |pass, person|
    rows = (0..127).to_a
    cols = (0..8).to_a
    pass.chomp.split('').each_with_index do |letter, index|
      if index <= 6
        if letter == 'F'
          rows = rows[0..rows.length/2-1]
        else
          rows = rows[rows.length/2..-1]
        end
      elsif index > 6
        if letter == 'L'
          cols = cols[0..cols.length/2-1]
        else
          cols = cols[cols.length/2..-1]
        end
      end
    end
    seats[person] = rows[0]*8 + cols[0]
  end
  seats
end

seats = (53..896).to_a
tickets = bpass.sort_by{|k, v| v}.map {|el|el[1]}
p seats - tickets
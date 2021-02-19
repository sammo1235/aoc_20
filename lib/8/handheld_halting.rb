class HandheldHalting
  attr_accessor :accumalator, :current_ins, :call_list, :ins
  def initialize(file = nil)
    @accumalator = 0
    @current_ins = 0
    @call_list = []
    if file.nil?
      instructions = File.open('./lib/8/data.txt', 'r').readlines
      @ins = instructions.each_with_object({}).with_index {|(ins, hash), index| hash[index] = ins.chomp }
    else
      @ins = file
    end
  end

  def part_one 
    run_instruction(true)
  end

  def run_instruction(part_one)
    if current_ins == 630
      return accumalator
    end

    if call_list.include? current_ins
      if part_one
        return accumalator
      else
        return false
      end
    else
      call_list << current_ins
    end

    op = ins[current_ins].split(' ').first
    value = ins[current_ins].split(' ').last
    plus_minus = value.scan(/\D/)[0]
    amount = value.scan(/\d+/)[0].to_i

    if op == "acc"
      self.current_ins += 1
      if plus_minus == "+"
        self.accumalator += amount
        run_instruction(part_one)
      else
        self.accumalator -= amount
        run_instruction(part_one)
      end
    elsif op == "jmp"
      if plus_minus == "+"
        self.current_ins += amount
        run_instruction(part_one)
      else
        self.current_ins -= amount
        run_instruction(part_one)
      end
    elsif op == "nop"
      self.current_ins += 1
      run_instruction(part_one)
    else
      raise StandardError => e
    end
  end
end

class FixHalting
  attr_accessor :last_seen, :ins
  def initialize
    @last_seen = 0
    instructions = File.open('./lib/8/data.txt', 'r').readlines
    @ins = instructions.each_with_object({}).with_index {|(ins, hash), index| hash[index] = ins.chomp }
  end

  def change_data
    ins.each do |k, v|
      if v.split(' ').first == 'jmp'
        if k > last_seen
          last_seen = k
          op = v.split(' ').last
          ins[k] = "nop #{op}"
          res = attempt_fix
          if res
            return res
          else
            ins[k] = "jmp #{op}"
          end
        end
      end
    end
  end

  def attempt_fix
    machine = HandheldHalting.new(ins)
    if machine.run_instruction(false)
      return machine.accumalator
    else
      false
    end
  end
end

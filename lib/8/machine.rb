require 'byebug'
class Machine
  attr_accessor :accumalator, :current_ins, :call_list, :ins
  def initialize(file=nil)
    @accumalator = 0
    @current_ins = 0
    @call_list = []
    if file.nil?
      instructions = File.open('./data.txt', 'r').readlines
      @ins = instructions.each_with_object({}).with_index {|(ins, hash), index| hash[index] = ins.chomp }
    else
      @ins = file
    end
  end

  def run_instruction
    if current_ins == 630
      # puts "program terminating"
      return accumalator
    end

    # puts "running ins number #{current_ins+1}: #{ins[current_ins]}"
    if call_list.include? current_ins
      # puts "program stopped with acc value of #{accumalator}"
      return false
    else
      call_list << current_ins
    end

    op = ins[current_ins].split(' ').first
    value = ins[current_ins].split(' ').last
    if op == "acc"
      self.current_ins += 1
      plus_minus = value.scan(/\D/)[0]
      if plus_minus == "+"
        # debugger
        self.accumalator += value.scan(/\d+/)[0].to_i
        run_instruction
      else
        self.accumalator -= value.scan(/\d+/)[0].to_i
        run_instruction
      end
    elsif op == "jmp"
      plus_minus = value.scan(/\D/)[0]
      if plus_minus == "+"
        self.current_ins += value.scan(/\d+/)[0].to_i
        run_instruction
      else
        self.current_ins -= value.scan(/\d+/)[0].to_i
        run_instruction
      end
    elsif op == "nop"
      # debugger
      self.current_ins += 1
      run_instruction
    else
      p "not recoginised"
    end
  end
end


class FixMachine
  attr_accessor :last_seen, :ins
  def initialize
    @last_seen = 0
    instructions = File.open('./data.txt', 'r').readlines
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
            p res
            return
          else
            ins[k] = "jmp #{op}"
          end
        end
      end
    end
  end

  def attempt_fix
    machine = Machine.new(ins)
    if machine.run_instruction
      return machine.accumalator
    else
      return false
    end
  end
end

FixMachine.new().change_data
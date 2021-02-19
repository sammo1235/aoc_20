require './lib/8/handheld_halting'

RSpec.describe HandheldHalting do
  let(:halting) { described_class.new }
  let(:fix_halting) { FixHalting.new }

  describe '#part_one' do
    it 'returns accumalator just before instruction is repeated' do
      expect(halting.part_one).to eq(1179)
    end
  end

  describe '#part_two' do
    it 'returns required number of bags inside shiny gold bag' do
      expect(fix_halting.change_data).to eq(1089)
    end
  end
end

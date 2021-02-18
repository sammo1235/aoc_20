require './lib/7/handy_haversacks'

RSpec.describe HandyHaversacks do
  let(:bags) { described_class.new }

  describe '#part_one' do
    it 'returns number of bag colours that can eventually contain a shiny gold bag' do
      expect(bags.part_one).to eq(226)
    end
  end

  describe '#part_two' do
    it 'returns required number of bags inside shiny gold bag' do
      expect(bags.part_two).to eq(9569)
    end
  end
end

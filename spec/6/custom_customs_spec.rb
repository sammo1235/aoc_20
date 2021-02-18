require './lib/6/custom_customs'

RSpec.describe CustomCustoms do
  let(:customs) { described_class.new }

  describe '#part_one' do
    it 'sum of counts of questions to which anyone answered yes' do
      expect(customs.part_one).to eq(6565)
    end
  end

  describe '#part_two' do
    it 'returns the last available seat' do
      expect(customs.part_two).to eq(3137)
    end
  end
end

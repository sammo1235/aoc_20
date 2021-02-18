require './lib/3/slope'

RSpec.describe Slope do
  let(:slope) { described_class.new }

  describe '#part_one' do
    it 'returns number of trees you would hit with three column jump' do
      expect(slope.part_one).to eq(171)
    end
  end

  describe '#part_two' do
    it 'return the product of the trees hit with differing routes' do
      expect(slope.part_two).to eq(1206576000)
    end
  end
end

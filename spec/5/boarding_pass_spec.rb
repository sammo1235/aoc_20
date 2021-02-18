require './lib/5/boarding_pass'

RSpec.describe BoardingPass do
  let(:boarding) { described_class.new }

  describe '#part_one' do
    it 'returns highest seat number on the plane' do
      expect(boarding.part_one).to eq(896)
    end
  end

  describe '#part_two' do
    it 'returns the last available seat' do
      expect(boarding.part_two).to eq(659)
    end
  end
end

require './lib/2/password_philosophy'

RSpec.describe Password do
  let(:password) { described_class.new }

  describe '#part_one' do
    it 'returns number of valid passwords with character count policy' do
      expect(password.part_one).to eq(434)
    end
  end

  describe '#part_two' do
    it 'return the product of the three numbers that add up to 2020' do
      expect(password.part_two).to eq(509)
    end
  end
end

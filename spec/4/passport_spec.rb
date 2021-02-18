require './lib/4/passport'

RSpec.describe Passport do
  let(:passport) { described_class.new }

  describe '#part_one' do
    it 'returns number of valid passports (all fields except cid)' do
      expect(passport.part_one).to eq(242)
    end
  end

  describe '#part_two' do
    it 'return the number of valid passports (added rules)' do
      expect(passport.part_two).to eq(186)
    end
  end
end

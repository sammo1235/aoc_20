require './lib/1/report_repair'

RSpec.describe ReportRepair do
  let(:report) { described_class.new }

  describe '#part_one' do
    it 'returns the sum of the two numbers that add up to 2020' do
      expect(report.part_one).to eq(927684)
    end
  end

  describe '#part_two' do
    it 'return the product of the three numbers that add up to 2020' do
      expect(report.part_two).to eq(292093004)
    end
  end
end

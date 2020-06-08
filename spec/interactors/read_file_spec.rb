require 'rails_helper'

RSpec.describe ReadFile, type: :interactor do
  subject(:result) { ReadFile.call(report: report) }

  describe ".call" do
    context "when given valid params" do
      let(:report) { FactoryBot.create(:report) }

      it "succeeds" do
        expect(result.success?).to eq(true)
      end

      it "returns an array with all lines in the file" do
        expect(result.lines.class).to eq(Array)
        expect(result.lines.empty?).to eq(false)
      end
    end

    context "when given invalid params" do
      context "missing report" do
        let(:report) { nil }
        it "fails" do
          expect(result.success?).to eq(false)
          expect(result.errors.include? "Missing report").to eq(true)
        end
      end
      context "missing report attachment" do
        let(:report) { FactoryBot.create(:report, :invalid) }
        it "fails" do
          expect(result.success?).to eq(false)
          expect(result.errors.include? "Report does not contain valid file").to eq(true)
        end
      end
    end
  end
end
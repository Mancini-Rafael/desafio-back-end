require 'rails_helper'

RSpec.describe BuildOperation, type: :interactor do
  subject(:result) { BuildOperation.call(report: report, lines: lines) }

  describe ".call" do
    context "when given valid params" do
      let(:report) { FactoryBot.create(:report) }
      let(:lines) { ["1201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       ",
                     "2201903010000013200556418150633123****7687145607MARIA JOSEFINALOJA DO Ó - MATRIZ"] }

      it "succeeds" do
        expect(result.success?).to eq(true)
      end

      it "returns an array with all operation object attributes" do
        operation = Operation.new(
          report_id: report.id,
          mode: "debit",
          date: DateTime.parse("20190301 153453 -3"),
          receiver_cpf: "09620676017",
          card: "4753****3153",
          store_owner_name: "JOÃO MACEDO",
          store_name: "BAR DO JOÃO",
          amount: Money.new(14200)
        )
        expect(result.operations.class).to eq(Array)
        expect(result.operations.empty?).to eq(false)
        expect(result.operations.first.attributes == operation.attributes).to eq(true)
        expect(result.operations.last.amount.negative?).to eq(true)
      end
    end

    context "when given invalid params" do
      context "missing lines" do
        let(:lines) { nil }
        let(:report) { nil }
        it "fails" do
          expect(result.success?).to eq(false)
          expect(result.errors.include? "Missing lines").to eq(true)
        end
      end
      context "missing report" do
        let(:report) { nil }
        let(:lines) { ["line"] }
        it "fails" do
          expect(result.success?).to eq(false)
          expect(result.errors.include? "Missing report").to eq(true)
        end
      end
    end
  end
end
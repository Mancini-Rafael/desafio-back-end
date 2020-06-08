require 'rails_helper'

RSpec.describe CommitOperation, type: :interactor do
  subject(:result) { CommitOperation.call(operations: operations) }

  describe ".call" do
    context "when given valid params" do
      let(:report) { FactoryBot.create(:report) }
      let(:operations) { 
        [
          Operation.new(
          report_id: report.id,
          mode: "financing",
          date: DateTime.parse("20190301 153453 -3"),
          receiver_cpf: "09620676017",
          card: "4753****3153",
          store_owner_name: "JOÃO MACEDO",
          store_name: "BAR DO JOÃO",
          amount: Money.new(14200)),
          Operation.new(
          report_id: report.id,
          mode: "financing",
          date: DateTime.parse("20190301 153453 -3"),
          receiver_cpf: "09620676017",
          card: "4753****3153",
          store_owner_name: "JOÃO MACEDO",
          store_name: "BAR DO JOÃO",
          amount: Money.new(14200))
        ]
       }

      it "succeeds" do
        expect(result.success?).to eq(true)
      end

      it "imports all operations to the database" do
        expect(Operation.count).to eq(0)
        result
        expect(Operation.count).to eq(2)
      end
    end

    context "when given invalid params" do
      context "missing operations" do
        let(:operations) { nil }
        it "fails" do
          expect(result.success?).to eq(false)
          expect(result.errors.include? "Missing operations").to eq(true)
        end
      end
    end
  end
end
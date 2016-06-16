require "spec_helper"

describe ActiveRecord::Missing::ForeignKeys do
  subject { ActiveRecord::Missing::ForeignKeys.call ignore }

  let(:ignore) do
    {
      table6: :c1_id,
      table7: [:c1_id, :c2_id],
      table_deprecated: :all,
      "table8" => ["c1_id", "c2_id"],
      "table9" => "all"
    }
  end
  let(:connection) { FakeConnection.new data }

  before { allow(ActiveRecord::Missing).to receive(:connection).and_return connection }

  context "when there are missing keys" do
    let(:data) do
      {
        "table1" => {
          "columns" => { "column1" => :integer, "column2" => :string },
          "fk" => %w()
        },
        "table2" => {
          "columns" => { "column1_id" => :integer, "column2_id" => :string },
          "fk" => %w()
        },
        "table3" => {
          "columns" => { "column1_id" => :integer, "column2_id" => :integer },
          "fk" => %w(column1_id)
        },
        "table4" => {
          "columns" => { "column1_id" => :integer, "column2_id" => :integer },
          "fk" => %w(column1_id column2_id)
        },
        "table5" => {
          "columns" => { "column_id" => :integer, "column_type" => :string },
          "fk" => %w()
        },
        "table6" => {
            "columns" => { "c1_id" => :integer },
            "fk" => %w()
        },
        "table7" => {
            "columns" => { "c1_id" => :integer, "c2_id" => :integer },
            "fk" => %w()
        },
        "table8" => {
            "columns" => {},
            "fk" => %w()
        },
        "table9" => {
            "columns" => { "c1_id" => :integer, "c2_id" => :integer },
            "fk" => %w()
        },
        "table_deprecated" => {
          "columns" => { "column_id" => :integer },
          "fk" => %w()
        }
      }
    end

    it { is_expected.not_to have_key "table1" }
    it { is_expected.to have_exactly(2).tables }
    its(["table2"]) { is_expected.to have_exactly(1).column }
    its(["table2"]) { is_expected.to include "column1_id" }
    its(["table3"]) { is_expected.to have_exactly(1).column }
    its(["table3"]) { is_expected.to include "column2_id" }
    it { is_expected.not_to have_key "table4" }
    it { is_expected.not_to have_key "table_deprecated" }
    it { is_expected.not_to have_key "table6" }
    it { is_expected.not_to have_key "table7" }
    it { is_expected.not_to have_key "table8" }
    it { is_expected.not_to have_key "table9" }
    it { is_expected.not_to have_key "table5" }
  end

  context "when there are no missing foreign keys" do
    let(:ignore) { {} }
    let(:data) do
      {
        "table_name" => {
          "columns" => { "column_id" => :integer, "column" => :integer },
          "fk" => %w(column_id)
        }
      }
    end

    it { is_expected.to be_empty }
  end

  context "when the ignored table not exist in database" do
    subject { -> { ActiveRecord::Missing::ForeignKeys.call ignore } }

    let(:ignore) { { table11: :c1_id } }
    let(:data) do
      {
        "table12" => {
          "columns" => { "c1_id" => :integer },
          "fk" => %w(column_id)
        }
      }
    end

    it { is_expected.to raise_error ActiveRecord::Missing::TableNotFoundError }
  end

  context "when the ignored column not exist in database" do
    subject { -> { ActiveRecord::Missing::ForeignKeys.call ignore } }

    let(:ignore) { { table13: :c1_id, table14: :c2_id } }
    let(:data) do
      {
        "table13" => {
          "columns" => { "c1_id" => :integer },
          "fk" => %w(column_id)
        },
        "table14" => {
          "columns" => { "c1_id" => :integer },
          "fk" => %w(column_id)
        }
      }
    end

    it { is_expected.to raise_error ActiveRecord::Missing::ColumnNotFoundError }
  end
end

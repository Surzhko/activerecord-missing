require "spec_helper"

describe ActiveRecord::Missing::Configurations::ForeignKeys do
  its(:ignore_data) { is_expected.to be_empty }

  describe ".ignore" do
    let(:config) { ActiveRecord::Missing::Configurations::ForeignKeys.new }

    it { expect { config.ignore :table }.to change(config, :ignore_data).to "table" => "all" }
    it { expect { config.ignore "table" }.to change(config, :ignore_data).to "table" => "all" }
    it { expect { config.ignore :table, :all }.to change(config, :ignore_data).to "table" => "all" }
    it { expect { config.ignore "table", "all" }.to change(config, :ignore_data).to "table" => "all" }
    it { expect { config.ignore :table, :c1, :c2 }.to change(config, :ignore_data).to "table" => %w(c1 c2) }
    it { expect { config.ignore "table", "c1", "c2" }.to change(config, :ignore_data).to "table" => %w(c1 c2) }
  end
end

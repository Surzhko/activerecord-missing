require "spec_helper"

describe ActiveRecord::Missing do
  it "has a version number" do
    expect(ActiveRecord::Missing::VERSION).not_to be nil
  end

  it { is_expected.to respond_to :configure }

  describe ".configuration" do
    subject { ActiveRecord::Missing.configuration }

    it { is_expected.to be_kind_of ActiveRecord::Missing::Configurations::Base }
  end

  describe ".reset" do
    subject { -> { ActiveRecord::Missing.reset } }

    it { is_expected.to change(ActiveRecord::Missing, :configuration) }
  end
end

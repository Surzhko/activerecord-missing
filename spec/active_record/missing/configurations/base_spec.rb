require "spec_helper"

describe ActiveRecord::Missing::Configurations::Base do
  let(:fk_config_class) { ActiveRecord::Missing::Configurations::ForeignKeys }

  its(:foreign_keys_config) { is_expected.to be_kind_of fk_config_class }
  it { is_expected.to respond_to :foreign_keys }
end

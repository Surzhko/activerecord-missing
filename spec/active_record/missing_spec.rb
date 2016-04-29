require "spec_helper"

describe ActiveRecord::Missing do
  it "has a version number" do
    expect(ActiveRecord::Missing::VERSION).not_to be nil
  end
end

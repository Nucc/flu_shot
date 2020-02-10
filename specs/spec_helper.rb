$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "flu_shot"

require "minitest/autorun"
require "minitest/spec"
require "mocha/minitest"

class Minitest::Spec
  before :each do
    FluShot.inject_only_if { true }
  end
end
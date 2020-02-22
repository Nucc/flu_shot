require 'spec_helper'

describe FluShot::Sneeze do
  it 'can be raised as an exception' do
    assert_raises do
      raise FluShot::Sneeze.new
    end
  end

  it 'can wrap another exception' do
    sneeze = FluShot::Sneeze.new(StandardError.new)
    assert_equal StandardError, sneeze.wrapped_exception.class
  end
end
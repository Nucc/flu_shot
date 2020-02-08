require "spec_helper"

describe FluShot do
  it 'has a VERSION number' do
    refute_nil ::FluShot::VERSION
  end

  describe '#inject' do
    it 'requires a name' do
      assert_nil FluShot.inject('name')
    end

    it 'executes the given block' do
      ret = FluShot.inject('name') do
        'hello'
      end

      assert_equal 'hello', ret
    end

    it 'executes the given block even if exception occurs' do
      FluShot.stubs(:_before_init).raises(StandardError, 'should be catched')
      ret = FluShot.inject('name') do
        'hello'
      end

      assert_equal 'hello', ret
    end

    it 'can be switched off' do
      FluShot.inject_only_if do
        false
      end
      FluShot.expects(:_before_init).never
      FluShot.inject('name')
    end
  end

  describe '#inject_only_if' do
    it 'does not aborts when exception occurs in it' do
      FluShot.inject_only_if do
        raise 'it should be catched'
      end
    end
  end
end

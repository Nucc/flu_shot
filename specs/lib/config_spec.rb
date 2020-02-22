require 'spec_helper'

describe FluShot::Config do

  describe '#storage' do

    before do
      FluShot::Config.storage = nil
    end

    it 'returns memory storage by default' do
      assert FluShot::Config.storage.is_a?(FluShot::Storage::Memory)
    end

    it 'returns the same storage instance' do
      assert_equal FluShot::Config.storage.object_id, FluShot::Config.storage.object_id
    end

    it 'can register other storage objects too' do
      FluShot::Config.storage = FluShot::Storage::Redis.new(Redis.new)
      assert FluShot::Config.storage.is_a?(FluShot::Storage::Redis)
    end
  end
end
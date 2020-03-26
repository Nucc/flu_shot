require 'spec_helper'

describe :inject do

  class Rand123 < FluShot::Vaccine
    label :injection_test_vaccine

    def initialize(*args)
      test(*args)
    end

    def test(*args)
    end
  end

  it 'executes all the vaccines from a prescription' do
    FluShot::Prescription.spec(:injection_name) do |p|
      p.add(:injection_test_vaccine, {})
    end

    Rand123.any_instance.expects(:test).once
    FluShot.inject(:injection_name)
  end

  it 'works with Redis store' do
    FluShot::Config.storage = FluShot::Storage::Redis.new(Redis.new)
    FluShot::Prescription.spec(:injection_name) do |p|
      p.add(:injection_test_vaccine, {})
    end

    Rand123.any_instance.expects(:test).once
    FluShot.inject(:injection_name)
  end

  it 'can receive local context variables' do
    FluShot::Prescription.spec(:injection_name) do |p|
      p.add(:injection_test_vaccine, {})
    end

    Rand123.any_instance.expects(:test).with(account: 'account_name').once
    FluShot.inject(:injection_name, account: 'account_name')
  end
end
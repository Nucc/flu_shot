require 'spec_helper'

describe :inject do

  class Rand123 < FluShot::Vaccine
    label :injection_test_vaccine

    def initialize(*args)
    end
  end

  class FilterMock < FluShot::Filter
    label :filter_mock

    def check(params = {})
      params[:allow]
    end
  end

  it 'executes all the vaccines from a prescription' do
    FluShot::Prescription.spec(:injection_name) do |p|
      p.add(:injection_test_vaccine, {})
    end

    Rand123.expects(:new).once
    FluShot.inject(:injection_name)
  end

  it 'works with Redis store' do
    FluShot::Config.storage = FluShot::Storage::Redis.new(Redis.new)
    FluShot::Prescription.spec(:injection_name) do |p|
      p.add(:injection_test_vaccine, {})
    end

    Rand123.expects(:new).once
    FluShot.inject(:injection_name)
  end

  it 'can receive local context variables' do
    FluShot::Prescription.spec(:injection_name) do |p|
      p.add(:injection_test_vaccine, {})
    end

    Rand123.expects(:new).with(account: 'account_name').once
    FluShot.inject(:injection_name, account: 'account_name')
  end

  it 'does not execute the vaccines after a filter returned false on #check' do
    FluShot::Prescription.spec(:injection_name) do |p|
      p.filter(:filter_mock, {allow: false})
      p.add(:vaccine_label, {param: 2})
    end

    Rand123.expects(:new).with(account: 'account_name').never
    FluShot.inject(:injection_name, account: 'account_name')
  end

  it 'does not execute the vaccines after a filter returned false on #check' do
    FluShot::Prescription.spec(:injection_name) do |p|
      p.filter(:filter_mock, {allow: true})
      p.add(:vaccine_label, {param: 2})
    end

    Rand123.expects(:new).never
    FluShot.inject(:injection_name, account: 'account_name')
  end

end
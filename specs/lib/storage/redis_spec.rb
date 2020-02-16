require 'spec_helper'

describe FluShot::Storage::Redis do
  before do
    connection = Redis.new
    @store = FluShot::Storage::Redis.new(connection)
    @store.reset
  end

  it 'returns [] when prescription is missing' do
    assert_equal [], @store.get('prescription_name')
  end

  it 'stores vaccine for a prescription' do
    @store.add('prescription_name', {vaccine: 'vaccine_name'})
    assert_equal 'vaccine_name', @store.get('prescription_name').first[:vaccine]
  end

  it 'stores vaccine with parameters' do
    @store.add('prescription_name', {vaccine: 'vaccine_name', params: {param: 'value'}})
    assert_equal 'value', @store.get('prescription_name').first[:params][:param]
  end

  it 'can reset itself' do
    @store.add('prescription_name', {param: 1})
    @store.reset
    assert_equal [], @store.get('prescription_name')
  end
end
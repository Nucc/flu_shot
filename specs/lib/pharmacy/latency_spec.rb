require 'spec_helper'

describe FluShot::Pharmacy::Latency do
  it 'adds x ms latency using the value parameter' do
    t = Time.now.to_f
    FluShot::Pharmacy::Latency.new(value: 1000)
    assert (Time.now.to_f - t) > 1
  end

  it 'can be used in a prescription' do
    FluShot::Prescription.spec(:name) do |p|
      p.add('pharmacy.latency', {value: 1000})
    end

    t = Time.now.to_f
    FluShot.inject(:name)
    assert (Time.now.to_f - t) > 1
  end
end
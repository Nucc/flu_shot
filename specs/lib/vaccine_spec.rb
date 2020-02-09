require 'spec_helper'

describe FluShot::Vaccine do
  it 'has an unknown label by default' do
    vaccine = FluShot::Vaccine.new
    assert_equal :unknown, vaccine.label
  end

  it 'has a label that registers itself in a repo' do
    Class.new(FluShot::Vaccine) { label :latency }
    assert FluShot::Vaccine.registered.include?(:latency)
  end

  it 'can have attributes' do
    vaccine = FluShot::Vaccine.new({min: 1000, max: 3000})
    assert_equal 1000, vaccine.attributes[:min]
    assert_equal 3000, vaccine.attributes[:max]
  end

  describe '#find' do
    it 'can initialize a vaccine from the label' do
      class Vaccine1 < FluShot::Vaccine
        label :vaccine1
      end
      assert_equal Vaccine1, FluShot::Vaccine.find(:vaccine1)
    end
  end

  describe '#use' do
    it 'finds and executes the vaccine' do
      class Vaccine2 < FluShot::Vaccine
        attr_reader :test_value
        label :latency

        def initialize(params = {})
          @test_value = :ok
        end
      end

      assert_equal :ok, FluShot::Vaccine.use(:latency).test_value
    end

    it 'finds and executes the vaccine with attributes' do
      class Vaccine3 < FluShot::Vaccine
        attr_reader :min, :max
        label :latency

        def initialize(params = {})
          @min = params[:min]
          @max = params[:max]
        end
      end

      assert_equal 1000, FluShot::Vaccine.use(:latency, {min: 1000, max: 3000}).min
      assert_equal 3000, FluShot::Vaccine.use(:latency, {min: 1000, max: 3000}).max
    end
  end
end
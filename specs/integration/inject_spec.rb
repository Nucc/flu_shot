require 'spec_helper'

describe :inject do
  it 'executes all the vaccines from a prescription' do
    class Rand123 < FluShot::Vaccine
      label :injection_test_vaccine

      def initialize(*args)
        test
      end

      def test
      end
    end

    FluShot::Prescription.spec(:injection_name) do |p|
      p.add(:injection_test_vaccine, {})
    end

    Rand123.any_instance.expects(:test).once
    FluShot.inject(:injection_name)
  end
end
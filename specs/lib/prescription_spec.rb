require 'spec_helper'

describe FluShot::Prescription do
  describe '#spec' do

    class VaccineMock < FluShot::Vaccine
      label :vaccine

      def initialize(*params)
        params
      end
    end

    it 'registers vaccines' do
      FluShot::Prescription.spec(:name) do |order|
        order.add(:vaccine)
      end

      assert_equal VaccineMock, FluShot::Prescription.for(:name).first
    end

    it 'remembers to the ingridients of the vaccines' do
      FluShot::Prescription.spec(:name) do |p|
        p.add(:vaccine, {param: 1})
        p.add(:vaccine, {param: 2})
      end

      assert_equal VaccineMock, FluShot::Prescription.for(:name).first
      assert_equal 2, FluShot::Prescription.for(:name).size
    end
  end
end
require 'spec_helper'

describe FluShot::Prescription do
  describe '#spec' do

    class VaccineMock < FluShot::Vaccine
      label :vaccine_label

      def initialize(*params)
        params
      end
    end

    it 'registers vaccines' do
      FluShot::Prescription.spec(:name) do |order|
        order.add(:vaccine_label)
      end

      assert_equal({:vaccine => :vaccine_label, :params => {}}, FluShot::Prescription.for(:name).first)
    end

    it 'remembers to the ingridients of the vaccines' do
      FluShot::Prescription.spec(:name) do |p|
        p.add(:vaccine_label, {param: 1})
        p.add(:vaccine_label, {param: 2})
      end

      assert_equal({:vaccine => :vaccine_label, :params => {:param => 1}}, FluShot::Prescription.for(:name).first)
      assert_equal 2, FluShot::Prescription.for(:name).size
    end

    it 'can apply filters' do
      FluShot::Prescription.spec(:name) do |order|
        order.filter(:vaccine_label)
      end

      assert_equal({:vaccine => :vaccine_label, :params => {}}, FluShot::Prescription.for(:name).first)
    end
  end
end
module FluShot
  describe Filter do

    class TestFilter < ::FluShot::Filter
      label :test_filter
      def check
        false
      end
    end

    it 'has a label' do
      assert_equal :test_filter, TestFilter.label
    end

    it 'has a check method that returns false by default' do
      refute FluShot::Filter.new.check
    end
  end
end
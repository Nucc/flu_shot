module FluShot
  module Storage
    class Memory
      def initialize
        @storage = {}
      end

      def add(prescription_name, vaccines)
        @storage[prescription_name] ||= []
        vaccines = [vaccines] unless vaccines.is_a?(Array)
        @storage[prescription_name] = vaccines
      end

      def get(prescription_name)
        @storage[prescription_name] || []
      end
    end
  end
end
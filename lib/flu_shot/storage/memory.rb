module FluShot
  module Storage
    class Memory
      def initialize
        @storage = {}
      end

      def add(prescription_name, vaccine_details)
        @storage[prescription_name] ||= []
        @storage[prescription_name] << vaccine_details
      end

      def get(prescription_name)
        @storage[prescription_name] || []
      end
    end
  end
end
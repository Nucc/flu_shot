module FluShot
  class Prescription
    def self.spec(name, &block)
      block.call(self.new(name)) if block_given?
    end

    def initialize(name)
      @name = name
      self.class.prescriptions[@name] = []
    end

    def add(vaccine, params = {})
      self.class.prescriptions[@name] << { vaccine: vaccine, params: params }
    end

    def self.for(name)
      Array(prescriptions[name])
    end

    private

    def self.prescriptions
      Thread.current[:presciptions] ||= {}
    end
  end
end
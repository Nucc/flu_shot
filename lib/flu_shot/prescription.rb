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
      self.class.prescriptions[@name] << { name: FluShot::Vaccine.find(vaccine), params: params }
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
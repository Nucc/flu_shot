module FluShot
  class Prescription
    def self.spec(name, &block)
      @@prescriptions ||= {}
      instance = self.new(name)
      @@prescriptions[name] = instance
      block.call(instance) if block_given?
    end

    def initialize(name)
      @name = name
      storage[@name] = []
    end

    def add(vaccine, params = {})
      storage[@name] << { name: FluShot::Vaccine.find(vaccine), params: params }
    end

    def self.for(name)
      @@storage[name].map{ |x| x[:name] }
    end

    private

    def storage
      @@storage ||= {}
    end
  end
end
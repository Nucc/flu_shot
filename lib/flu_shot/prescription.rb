module FluShot
  class Prescription
    def self.spec(name, &block)
      block.call(self.new(name)) if block_given?
    end

    def initialize(name)
      @name = name
      self.class.prescriptions.add(@name, [])
    end

    def add(vaccine, params = {})
      current = self.class.prescriptions.get(@name)
      current << { vaccine: vaccine, params: params }
      self.class.prescriptions.add(@name, current)
    end

    alias_method :filter, :add

    def self.for(name)
      prescriptions.get(name)
    end

    private

    def self.prescriptions
      Config.storage
    end
  end
end
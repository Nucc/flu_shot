module FluShot
  class Config
    def self.storage=(value)
      @@storage = value
    end

    def self.storage
      @@storage ||= Storage::Memory.new
    end
  end
end
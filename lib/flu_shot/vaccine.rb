# The idea here is to do something like this in the code:
#
# ... your business layer ...
# FluShot.inject(:user_profile_fetch)
#
# Define a latency vaccine that you can inject into your business layer
# and adds a random delay between 1 and 3 seconds.
#
# class Latency < FluShot::Vaccine
#   label :latency
#
#   def initialize(params)
#     sleep(rand(params[:max] - params[:min]) + params[:min])
#   end
# end
#
# FluShot.on :user_profile_fetch do
#   FluShot::Vaccine.use(:latency, {min: 1000, max: 3000})
# end
#
#
module FluShot
  class Vaccine
    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def self.label(name = nil)
      if name.nil?
        if defined?(@vaccine_name)
          @vaccine_name
        end || :unknown
      else
        @vaccine_name = name
        vaccines[name] = self
      end
    end

    def self.registered
      self.vaccines.keys
    end

    def self.find(name)
      self.vaccines[name]
    end

    def self.use(name, params = {})
      find(name).new(params)
    end

    def label
      self.class.label
    end

    private

    def self.vaccines
      Thread.current[:vaccines] ||= {}
    end
  end
end
module FluShot
  class Sneeze < StandardError
    def initialize(exception)
      @wrapped_exception = exception
    end

    attr_reader :wrapped_exception
  end
end
module FluShot
  module Pharmacy
    class Latency < FluShot::Vaccine

      label 'pharmacy.latency'

      def initialize(params = {})
        sleep (params[:value].to_f / 1000)
      end
    end
  end
end
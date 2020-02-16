require 'redis'
require 'yaml'

module FluShot
  module Storage
    class Redis
      def initialize(connection)
        @connection = connection
      end

      def add(prescription, vaccines)
        vaccines = [vaccines] unless vaccines.is_a?(Array)
        @connection.hset('flu_shot', prescription.to_s, YAML.dump(vaccines))
      end

      def get(name)
        value = @connection.hget('flu_shot', name)
        value ? YAML.load(value) : []
      end

      def reset
        @connection.hgetall('flu_shot').each_key do |x|
          @connection.hdel('flu_shot', x)
        end
      end
    end
  end
end
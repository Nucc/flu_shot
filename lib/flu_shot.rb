require "flu_shot/version"
require 'flu_shot/vaccine'
require 'flu_shot/prescription'
require 'flu_shot/config'
require 'flu_shot/sneeze'
require 'flu_shot/filter'


module FluShot
  module Storage
    autoload :Memory, 'flu_shot/storage/memory'
    autoload :Redis, 'flu_shot/storage/redis'
  end

  module Pharmacy
    autoload :Latency, 'flu_shot/pharmacy/latency'
  end

  class Error < StandardError; end

  def self.inject(name, params = {}, &block)
    if !before_filter.call
      return
    end

    Prescription.for(name).each do |prescription|
      klass = Vaccine.find(prescription[:vaccine])
      if (klass < ::FluShot::Filter)
        break unless klass.new.check(prescription[:params].merge(params))
      else
        klass.new(prescription[:params].merge(params))
      end
    end

    # @test
    _before_init
    block_given? ? block.call : nil

  rescue FluShot::Sneeze => sneeze
    raise sneeze.wrapped_exception

  rescue
    # @test
    _exception_muted
    block_given? ? block.call : nil
  end

  def self.inject_only_if(&block)
    Thread.current[:before_filter] = block
  end

  private

  def self.before_filter
    Thread.current[:before_filter] ||= Proc.new { true }
    Thread.current[:before_filter]
  end

  # @test
  def self._before_init
  end

  # @test
  def self._exception_muted
  end
end

require "flu_shot/version"
require 'flu_shot/vaccine'
require 'flu_shot/prescription'

module FluShot
  module Storage
    autoload :Memory, 'flu_shot/storage/memory'
    autoload :Redis, 'flu_shot/storage/redis'
  end

  class Error < StandardError; end

  def self.inject(name, &block)
    if !before_filter.call
      return
    end

    Prescription.for(name).each do |prescription|
      Vaccine.find(prescription[:vaccine]).new(prescription[:params])
    end

    # @test
    _before_init
  rescue
    # @test
    _exception_muted

  ensure
    return block_given? ? block.call : nil
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

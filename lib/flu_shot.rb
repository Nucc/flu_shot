require "flu_shot/version"
require 'flu_shot/vaccine'
require 'flu_shot/prescription'

module FluShot
  class Error < StandardError; end

  def self.inject(name, &block)
    return if before_filter && before_filter.call

    # @test
    _before_init
  rescue
    # @test
    _exception_muted

  ensure
    return block_given? ? block.call : nil
  end

  def self.inject_only_if(&block)
    @before_filter = block
  end

  private

  attr_reader :before_filter

  # @test
  def self._before_init
  end

  # @test
  def self._exception_muted
  end
end

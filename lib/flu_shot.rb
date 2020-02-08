require "flu_shot/version"

module FluShot
  class Error < StandardError; end

  def self.inject(name, &block)
    return if before_filter && before_filter.call

    _before_init
  rescue
    _exception_muted

  ensure
    return block_given? ? block.call : nil
  end

  def self.inject_only_if(&block)
    @before_filter = block
  end

  private

  attr_reader :before_filter

  # for testing purposes to raise exceptions from the test
  def self._before_init
  end

  def self._exception_muted
  end
end

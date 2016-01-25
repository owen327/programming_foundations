class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @max = size
    @buffer = {}
    @counter = 0
  end

  def read
    oldest_key = (@counter - @buffer.size) % @max
    @buffer.delete(oldest_key) { fail BufferEmptyException }
  end

  def write!(element)
    record(element) { read }
  end

  def write(element)
    record(element) { fail BufferFullException }
  end

  def clear
    initialize(@max)
  end

  private

  def record(element, &block)
    return if element.nil?
    block.call if @buffer.size == @max
    @buffer[@counter] = element
    @counter += 1
    @counter %= @max
  end
end

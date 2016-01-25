class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @max = size
    @buffer = {}
  end

  def read
    @buffer.delete(@buffer.keys.min) { fail BufferEmptyException }
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
    @buffer[Time.now] = element
  end
end

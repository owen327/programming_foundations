class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @max = size
    @buffer = {}
    @counter = 0
  end

  def read
    @buffer.delete(@buffer.keys.min) { fail BufferEmptyException }
  end

  def write(element)
    return if element.nil?
    fail BufferFullException if @buffer.size == @max
    @buffer[@counter] = element
    @counter += 1
  end

  def write!(element)
    return if element.nil?
    read if @buffer.size == @max
    write(element)
  end

  def clear
    initialize(@max)
  end
end

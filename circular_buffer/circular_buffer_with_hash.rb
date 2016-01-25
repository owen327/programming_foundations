class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @max = size
    @buffer = {}
    @counter = 0
  end

  def read
    oldest_key = (@counter + @max - @buffer.size) % @max
    @buffer.delete(oldest_key) { fail BufferEmptyException }
  end

  def write!(element)
    return if element.nil?
    read if @buffer.size == @max
    write(element)
  end

  def write(element)
    return if element.nil?
    fail BufferFullException if @buffer.size == @max
    @buffer[@counter] = element
    @counter += 1
    @counter %= @max
  end

  def clear
    initialize(@max)
  end
end

class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @buffer = []
    @max = size
  end

  def read
    fail BufferEmptyException if @buffer.empty?
    @buffer.shift
  end

  def write(element)
    return if element.nil?
    fail BufferFullException if @buffer.size == @max
    @buffer << element
  end

  def clear
    @buffer.clear
  end

  def write!(element)
    return if element.nil?
    read if @buffer.size == @max
    write(element)
  end
end

class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @buffer = []
    @max = size
  end

  def read
    @buffer.delete(@buffer[0]) { fail BufferEmptyException }
  end

  def write(element)
    fail BufferFullException if @buffer.size == @max
    @buffer << element unless element.nil?
  end

  def clear
    @buffer.clear
  end

  def write!(element)
    return if element.nil?
    if @buffer.size == @max
      read
      write(element)
    else
      write(element)
    end
  end
end

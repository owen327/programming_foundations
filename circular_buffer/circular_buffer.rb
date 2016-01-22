class BufferEmptyException < StandardError; end

class BufferFullException < StandardError; end

class CircularBuffer
  def initialize(size)
    @buffer = []
    @max = size
  end

  def read
    fail BufferEmptyException if @buffer.empty?
    @buffer.delete_at(0)
  end

  def write(element)
    fail BufferFullException if @buffer.size == @max
    @buffer << element unless element.nil?
  end

  def clear
    @buffer = []
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

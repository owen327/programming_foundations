class BufferEmptyException < StandardError;end

class BufferFullException < StandardError;end

class CircularBuffer
  def initialize(size)
    @buffer = []
    @max = size
  end

  def read
    fail BufferEmptyException if @buffer.last == nil
    @buffer.delete_at(0)
  end

  def write(element)
    fail BufferFullException if @buffer.size == @max
    @buffer << element if element != nil
  end

  def clear
    @buffer = []
  end

  def write!(element)
    return if element == nil
    if @buffer.size == @max
      self.read
      self.write(element)
    else
      self.write(element)
    end
  end
end

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

  def write(num)
    fail BufferFullException if @buffer.size == @max
    @buffer << num if num != nil
  end

  def clear
    @buffer = []
  end

  def write!(num)
    return if num == nil
    if @buffer.size == @max
      self.read
      self.write(num)
    else
      self.write(num)
    end
  end
end

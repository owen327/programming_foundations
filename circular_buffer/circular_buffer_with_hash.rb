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
    reset_counter if @counter == @max
  end

  def write!(element)
    return if element.nil?
    read if @buffer.size == @max
    write(element)
  end

  def clear
    initialize(@max)
  end

  private

  def reset_counter
    new_buffer = {}
    (@max).times { |i| new_buffer[i] = @buffer.delete(@buffer.keys.min) }
    @buffer = new_buffer.reject { |_,value| value.nil? }
    @counter = @buffer.size
  end
end

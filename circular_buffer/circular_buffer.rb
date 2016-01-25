class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @buffer = Array.new(size)
    @start_index = 0
    @end_index = 0
    @size = size
  end

  def read
    fail BufferEmptyException if @buffer.all?(&:nil?)
    show = @buffer[@end_index]
    @buffer[@end_index] = nil
    @end_index = increment(@end_index)
    show
  end

  def write(element)
    return if element.nil?
    fail BufferFullException if @buffer.all?
    @buffer[@start_index] = element
    @start_index = increment(@start_index)
  end

  def clear
    initialize(@size)
  end

  def write!(element)
    return if element.nil?
    read if @buffer.all?
    write(element)
  end

  private

  def increment(index)
    index += 1
    index %= @size
  end
end

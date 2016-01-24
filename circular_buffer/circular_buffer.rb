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
    fail BufferEmptyException if buffer_empty?
    show = @buffer[@end_index]
    @buffer[@end_index] = nil
    @end_index = increment(@end_index)
    show
  end

  def write(element)
    return if element.nil?
    fail BufferFullException if buffer_full?
    @buffer[@start_index] = element
    @start_index = increment(@start_index)
  end

  def clear
    initialize(@size)
  end

  def write!(element)
    return if element.nil?
    read if buffer_full?
    write(element)
  end

  private

  def buffer_full?
    @buffer.all? { |elements| elements }
  end

  def buffer_empty?
    @buffer.all?(&:nil?)
  end

  def increment(index)
    return 0 if index == @size - 1
    index + 1
  end
end

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
    @end_index += 1
    @end_index = 0 if @end_index == @size
    show
  end

  def write(element)
    return if element.nil?
    fail BufferFullException if @buffer.all? { |elements| elements }
    @buffer[@start_index] = element
    @start_index += 1
    @start_index = 0 if @start_index == @size
  end

  def clear
    initialize(@size)
  end

  def write!(element)
    return if element.nil?
    read if @buffer.all? { |elements| elements }
    write(element)
  end
end

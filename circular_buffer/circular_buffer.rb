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
    record(element) { fail BufferFullException }
  end

  def clear
    initialize(@size)
  end

  def write!(element)
    record(element) { read }
  end

  private

  def increment(index)
    index = (index + 1) % @size
  end

  def record(element, &block)
    return if element.nil?
    block.call if @buffer.all?
    @buffer[@start_index] = element
    @start_index = increment(@start_index)
  end
end

class Fibonacci
  def all()
    a, b = 1, 0
    Enumerator.new do |yielder|
      loop do
        c = a + b
        a = b
        b = c
        yielder.yield b
      end
    end
  end

  def list(count)
    all.take(count)
  end

  def get(index)
    list(index+1).to_a.last
  end
end

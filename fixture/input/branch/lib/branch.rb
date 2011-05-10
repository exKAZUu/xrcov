class A
  def b(n)
    if n > 0
      p 'n > 0'
    else
      p 'n <= 0'
    end
  end
end

A.new.b(1)

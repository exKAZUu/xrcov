class Sample
  def test(i)
    j = 10
    if i == 0 && j == 10 and i != j then
      p 't'
    else
      p 'f'
    end
    
    str = nil
    2.times { |c|
      str = %Q{
      if i == #{i} && j == #{j} and i != j then
        p 't'
      else
        p 'f'
      end
}
      
      eval(str)
      i = i + 1
    }
    
    i = 1
    eval(str)
  end
end

def func(v)
  if v >= 0
    eval (%Q{
      if #{v} == 0
        puts 'v is 0'
      else
        puts 'v is grater than 0'
      end
    })
  end
end

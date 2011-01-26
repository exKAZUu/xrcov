require 'xrcov'
require 'xrcov/coverage_fileout'
stmt_cov(0,0,(def func(v)
  stmt_cov(1,0,(if pred_cov(5,48,(v >= 0))
    stmt_cov(2,0,(eval eval_cov(6,'xrcov/test.rb',((stmt_cov(3,0,(%Q{
      if #{stmt_cov(4,0,(v))} == 0
        puts 'v is 0'
      else
        puts 'v is grater than 0'
      end
    })))))))
  end))
end))
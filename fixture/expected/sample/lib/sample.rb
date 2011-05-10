require 'xrcov'
$xrcov_out_dir ||= '/media/sf_Linux/xrcov/fixture/output/sample/lib'
require 'xrcov/coverage_fileout'
(XrcovOut.stmt(0,0);class Sample
  (XrcovOut.stmt(1,0);def test(i)
    (XrcovOut.stmt(2,0);j = 10)
    (XrcovOut.stmt(3,0);if XrcovOut.pred(18,1,(XrcovOut.pred(16,2,(i == 0)) && XrcovOut.pred(17,2,(j == 10)) and XrcovOut.pred(15,2,(i != j)))) then
      (XrcovOut.stmt(8,0);p 't')
    else
      (XrcovOut.stmt(9,0);p 'f')
    end)
    
    (XrcovOut.stmt(4,0);str = nil)
    (XrcovOut.stmt(5,0);2.times { |c|
      (XrcovOut.stmt(10,0);str = %Q{      if i == #{(XrcovOut.stmt(13,0);i)} && j == #{(XrcovOut.stmt(14,0);j)} and i != j then
        p 't'
      else
        p 'f'
      end
})
      
      (XrcovOut.stmt(11,0);eval(XrcovOut.eval(19,(str))))
      (XrcovOut.stmt(12,0);i = i + 1)
    })
    
    (XrcovOut.stmt(6,0);i = 1)
    (XrcovOut.stmt(7,0);eval(XrcovOut.eval(20,(str))))
  end)
end)
require 'xrcov'
$xrcov_out_path ||= 'fixture/output'
require 'xrcov/coverage_fileout'
(XrcovOut.stmt(0,0);class A
  (XrcovOut.stmt(2,0);def b(n)
    (XrcovOut.stmt(3,0);if XrcovOut.pred(6,3,(n > 0))
      (XrcovOut.stmt(4,0);p 'n > 0')
    else
      (XrcovOut.stmt(5,0);p 'n <= 0')
    end)
  end)
end)

(XrcovOut.stmt(1,0);A.new.b(1))
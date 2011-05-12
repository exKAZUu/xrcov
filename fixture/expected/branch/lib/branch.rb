require 'xrcov'
$xrcov_out_dir ||= '/media/sf_Linux/xrcov/fixture/output/branch/lib'
require 'xrcov/coverage_fileout'
(XrcovOut.stmt(4,0);class A
  (XrcovOut.stmt(3,0);def b(n)
    (XrcovOut.stmt(2,0);if XrcovOut.pred(6,3,(n > 0))
      (XrcovOut.stmt(1,0);p 'n > 0')
    else
      (XrcovOut.stmt(0,0);p 'n <= 0')
    end)
  end)
end)

(XrcovOut.stmt(5,0);A.new.b(1))
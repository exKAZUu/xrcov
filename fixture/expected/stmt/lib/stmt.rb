require 'xrcov'
$xrcov_out_dir ||= '/media/sf_Linux/xrcov/fixture/output/stmt/lib'
require 'xrcov/coverage_fileout'
(XrcovOut.stmt(0,0);class A
  (XrcovOut.stmt(2,0);def a()
    (XrcovOut.stmt(3,0);i = 1)
    (XrcovOut.stmt(4,0);a = "#{(XrcovOut.stmt(6,0);i + 1)}")
    (XrcovOut.stmt(5,0);p a)
  end)
end)

(XrcovOut.stmt(1,0);A.new.a)
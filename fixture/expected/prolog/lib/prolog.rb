require 'xrcov'
$xrcov_out_dir ||= '/media/sf_Linux/xrcov/fixture/output/prolog/lib'
require 'xrcov/coverage_fileout'
(XrcovOut.stmt(8,0);class A
  (XrcovOut.stmt(7,0);def a()
    (XrcovOut.stmt(2,0);(XrcovOut.stmt(1,0);::Syslog.close) if ::XrcovOut.pred(9,3,(Syslog.opened?)))
    (XrcovOut.stmt(3,0);::Syslog.open( *args ))
    (XrcovOut.stmt(4,0);(XrcovOut.stmt(0,0);return) if XrcovOut.pred(10,3,(!::Syslog.opened?)))
    (XrcovOut.stmt(5,0);::Syslog.send(tag, *messages))
    (XrcovOut.stmt(6,0);::Syslog.inspect)
  end)
end)
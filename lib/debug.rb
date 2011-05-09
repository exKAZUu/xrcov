require 'xrcov'
$xrcov_out_dir ||= 'fixture/output/sample'
require 'xrcov/coverage_fileout'
(XrcovOut.stmt(470,0);require 'xrcov')
(XrcovOut.stmt(471,0);$xrcov_out_dir ||= 'fixture/output/stmt')
(XrcovOut.stmt(472,0);require 'xrcov/coverage_fileout')
((XrcovOut.stmt(473,0);XrcovOut.stmt(211,0));(XrcovOut.stmt(474,0);$LOAD_PATH << File.dirname(File.dirname(__FILE__))))
((XrcovOut.stmt(475,0);XrcovOut.stmt(212,0));(XrcovOut.stmt(476,0);require 'ripper2ruby'))
((XrcovOut.stmt(477,0);XrcovOut.stmt(213,0));(XrcovOut.stmt(478,0);require 'pp'))

((XrcovOut.stmt(479,0);XrcovOut.stmt(214,0));(XrcovOut.stmt(480,0);src = "class A\nend"))
((XrcovOut.stmt(481,0);XrcovOut.stmt(215,0));(XrcovOut.stmt(482,0);pp Ripper::RubyBuilder.build(src)))
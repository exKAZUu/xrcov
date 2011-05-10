require 'xrcov'
$xrcov_out_dir ||= '/media/sf_Linux/xrcov/fixture/output/fibonacci/lib'
require 'xrcov/coverage_fileout'
(XrcovOut.stmt(0,0);class Fibonacci
  (XrcovOut.stmt(1,0);def all()
    (XrcovOut.stmt(4,0);a, b = 1, 0)
    (XrcovOut.stmt(5,0);Enumerator.new do |yielder|
      (XrcovOut.stmt(6,0);loop do
        (XrcovOut.stmt(7,0);c = a + b)
        (XrcovOut.stmt(8,0);a = b)
        (XrcovOut.stmt(9,0);b = c)
        (XrcovOut.stmt(10,0);yielder.yield b)
      end)
    end)
  end)

  (XrcovOut.stmt(2,0);def list(count)
    (XrcovOut.stmt(11,0);all.take(count))
  end)

  (XrcovOut.stmt(3,0);def get(index)
    (XrcovOut.stmt(12,0);list(index+1).to_a.last)
  end)
end)
require 'fibonacci'

describe Fibonacci do
  describe '#list' do
    context 'given 10' do
      it 'get fibonacci' do
        f = Fibonacci.new
        f.list(10).to_a.should eq [1,1,2,3,5,8,13,21,34,55]
      end
    end

    context 'given 6' do
      it 'get fibonacci' do
        f = Fibonacci.new
        f.list(6).to_a.should eq [1,1,2,3,5,8]
      end
    end

    context 'given 0' do
      it 'get fibonacci' do
        f = Fibonacci.new
        f.list(0).to_a.should eq []
      end
    end
  end

  describe '#get' do
    context 'given 0' do
      it 'get fibonacci' do
        f = Fibonacci.new
        f.get(0).should eq 1
      end
    end
  end
end

require 'sample'

describe Sample do
  before(:all) do
    @sample = Sample.new()
  end

  it 'shuold run test(0) which returns "t"' do
    @sample.test(0).should == 't'
  end
end


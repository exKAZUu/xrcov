require 'spec_helper'

require 'fileutils'

FILE_NAME = "test.tsv"

def close_and_read(f)
  f.close()
  open(FILE_NAME) { |f| f.read }.should
end

describe TsvWriter do

  before(:each) do
    @out = TsvWriter.instance
    @out.file = @f = open(FILE_NAME, "w")
  end

  after(:each) do
    FileUtils.remove(FILE_NAME)
  end

  it 'should write one record which consists of a string item' do
    @out.write_last("abc")
    close_and_read(@f).should == "abc\n"
  end

  it 'should write some records which consists of a string item' do
    @out.write_last("abc")
    @out.write_last("zzzz")
    close_and_read(@f).should == "abc\nzzzz\n"
  end

  it 'should write some records which consists of some items' do
    @out.write(1)
    @out.write_last("abc")
    @out.write("a")
    @out.write_last("zzzz")
    close_and_read(@f).should == "1\tabc\na\tzzzz\n"
  end
end

require 'spec_helper'
require 'fileutils'

FILE_NAME = "test.tsv"

def close_and_read(f)
  f.close()
  open(FILE_NAME) { |f| f.read }.should
end

describe TsvWriter do

  before(:each) do
    @f = open(FILE_NAME, "w")
    @out = TsvWriter.new(@f)
  end

  after(:each) do
    FileUtils.safe_unlink(FILE_NAME)
  end

  describe '#write' do
    context 'given "abc"' do
      it 'writes' do
        @out.write('abc')
        close_and_read(@f).should eq "abc\t"
      end
    end

    context 'given "abc", "zzzz"' do
      it 'writes' do
        @out.write('abc')
        @out.write('zzzz')
        close_and_read(@f).should eq "abc\tzzzz\t"
      end
    end
  end

  describe '#write_last' do
    context 'given "abc"' do
      it 'writes' do
        @out.write_last('abc')
        close_and_read(@f).should eq "abc\n"
      end
    end

    context 'given "abc", "zzzz"' do
      it 'writes' do
        @out.write_last('abc')
        @out.write_last('zzzz')
        close_and_read(@f).should eq "abc\nzzzz\n"
      end
    end
  end

  describe '#write and #write_last' do
    context 'given #w:"abc", #wl:"zzzz", #w:"1", #wl:"1A"' do
      it 'writes' do
        @out.write('abc')
        @out.write_last('zzzz')
        @out.write('1')
        @out.write_last('1A')
        close_and_read(@f).should eq "abc\tzzzz\n1\t1A\n"
      end
    end
  end
end

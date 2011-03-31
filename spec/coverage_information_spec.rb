require 'spec_helper'
require 'stringio'
require 'fileutils'

describe CoverageInformation do
  include CoverageState

  before(:each) do
    @info = CoverageInformation.new
  end

  after(:each) do
    FileUtils.safe_unlink('tmp')
  end

  describe '#read' do
    it 'restores CoverageInformation' do
      StringIO.open("1\n#{B}\ta\t1\t2\tb\t0\t0\t0") { |io|
        @info.elems << CoverageElement.new(B, "a", [1, 2], "b")
        @info.static_eval_id = 1
        actual = CoverageInformation.read(io)
        actual.should eq @info
      }
    end
  end

  describe '#write' do
    it 'writes and restores itself' do
      @info.elems << CoverageElement.new(C, "", [3, 2], "ba")
      @info.static_eval_id = 1
      open('tmp', 'w') { |f|
        @info.write(f)
      }
      open('tmp', 'r') { |f|
        actual = CoverageInformation.read(f)
        actual.should eq @info
      }
    end
  end

  describe '#append' do
    it 'writes and restores itself' do
      @info.elems << CoverageElement.new(C, "", [3, 2], "ba")
      @info.static_eval_id = 1
      open('tmp', 'w') { |f|
        @info.write(f)
      }
      open('tmp', 'a') { |f|
        appended = CoverageInformation.new
        appended.elems << CoverageElement.new(S, "aa", [1, 1], "")
        appended.elems << CoverageElement.new(BC, "", [3, 3], "")
        appended.elems.each { |e|
          @info.elems << e
        }
        appended.append(f)
      }
      open('tmp', 'r') { |f|
        actual = CoverageInformation.read(f)
        actual.should eq @info
      }
    end
  end

  describe '#read_coverage_data' do
    it 'reads coverage data' do
      @info.elems << CoverageElement.new(B, "a", [1, 2], "b")
      @info.elems << CoverageElement.new(B, "b", [2, 2], "b")
      @info.elems << CoverageElement.new(B, "c", [3, 2], "b")
      io = StringIO.new("0,1,1\n0,1,2\n1,1,1\n1,1,1\n")
      @info.read_coverage_data(io)
      @info.elems[0].state.should == BOTH
      @info.elems[1].state.should == FALSE
      @info.elems[2].state.should == NONE
    end
  end
end

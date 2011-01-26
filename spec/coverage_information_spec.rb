require 'spec_helper'
require 'stringio'

describe CoverageInformation do
  before(:all) do
    @info = CoverageInformation.new
  end

  after(:all) do
    File.delete('tmp') if File.exist?('tmp')
  end

  context 'should restor itself' do
    it 'using write and read' do
      @info.elems << CoverageElement.new(ElementType::BRANCH, "a", [1, 2], "b")
      @info.ieval = 1
      actual = nil
      open('tmp', 'w') { |f|
        @info.write(f)
      }
      open('tmp', 'r') { |f|
        actual = CoverageInformation.read(f)
      }
      actual.ieval.should == @info.ieval
      actual.elems.should == @info.elems
    end

    it 'using write, append and read' do
      @info.elems << CoverageElement.new(ElementType::CONDITION, "", [3, 2], "ba")
      @info.ieval = 1
      actual = nil
      open('tmp', 'w') { |f|
        @info.write(f)
      }
      open('tmp', 'a') { |f|
        appended = CoverageInformation.new
        appended.elems << CoverageElement.new(ElementType::STATEMENT, "aa", [1, 1], "")
        appended.elems << CoverageElement.new(ElementType::BRANCH_AND_CONDITION, "", [3, 3], "")
        appended.elems.each { |e|
          @info.elems << e
        }
        appended.append(f)
      }
      open('tmp', 'r') { |f|
        actual = CoverageInformation.read(f)
      }
      actual.ieval.should == @info.ieval
      actual.elems.should == @info.elems
    end
  end

  it 'should read measured data' do
    @info.elems << CoverageElement.new(ElementType::BRANCH, "a", [1, 2], "b")
    @info.elems << CoverageElement.new(ElementType::BRANCH, "b", [2, 2], "b")
    @info.elems << CoverageElement.new(ElementType::BRANCH, "c", [3, 2], "b")
    io = StringIO.new("0,1,1\n0,1,2\n1,1,1\n1,1,1\n")
    @info.read_measured_data(io)
    @info.elems[0].state.should == CoverageState::BOTH
    @info.elems[1].state.should == CoverageState::FALSE
    @info.elems[2].state.should == CoverageState::NONE
  end
end

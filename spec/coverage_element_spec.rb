require 'spec_helper'

class Writer
  def initialize()
    @arr = []
  end

  def write(o)
    @arr << o.to_s
  end

  def write_last(o)
    write(o)
    ret = @arr
    @arr = []
    ret
  end
end

describe CoverageElement, "when range is (0...0)" do
  before(:all) do
    @info = CoverageInformation.new()
    @info.elems << CoverageElement.new(ElementType::BRANCH, "path", [1, 2], "tag")
    @e = @info.elems[0]
    @e.state = CoverageState::FALSE
    @out = Writer.new
  end

  def test_children_and_self_state(s)
    @e.state = s
    @e.children_and_self_state(@info).should == s
  end

  context 'get state of children & self' do
    it 'should be CoverageState::NONE' do
      test_children_and_self_state(CoverageState::NONE)
    end
    it 'should be CoverageState::FLASE' do
      test_children_and_self_state(CoverageState::NONE)
    end
    it 'should be CoverageState::TRUE' do
      test_children_and_self_state(CoverageState::TRUE)
    end
    it 'should be CoverageState::BOTH' do
      test_children_and_self_state(CoverageState::BOTH)
    end
  end

  def test_children_or_self_state(s)
    @e.state = s
    @e.children_or_self_state(@info).should == s
  end

  context 'get state of children & self' do
    it 'should be CoverageState::NONE' do
      test_children_or_self_state(CoverageState::NONE)
    end
    it 'should be CoverageState::FLASE' do
      test_children_or_self_state(CoverageState::NONE)
    end
    it 'should be CoverageState::TRUE' do
      test_children_or_self_state(CoverageState::TRUE)
    end
    it 'should be CoverageState::BOTH' do
      test_children_or_self_state(CoverageState::BOTH)
    end
  end

  it 'should write and read itself' do
    e = CoverageElement.new(ElementType::CONDITION, "/p", [2, 0], "", (1...2))
    e2 = CoverageElement.read(e.write(@out))
    e.type.should == e2.type
    e.path.should == e2.path
    e.pos.should == e2.pos
    e.tag.should == e2.tag
    e.state.should == e2.state
    e.child_range.should == e2.child_range
  end
end

describe CoverageElement, "when range is (1...3)" do
  before(:all) do
    @info = CoverageInformation.new()
    @info.elems << CoverageElement.new(nil, nil, nil, nil, (1...3))
    @info.elems << CoverageElement.new(nil, nil, nil, nil, nil)
    @info.elems << CoverageElement.new(nil, nil, nil, nil, nil)
    @info.elems << CoverageElement.new(nil, nil, nil, nil, nil)
    @e = @info.elems[0]
  end

  context 'get state of children & self' do
    it 'should be CoverageState::NONE' do
      @info.elems[0].state = CoverageState::FALSE
      @info.elems[1].state = CoverageState::BOTH
      @info.elems[2].state = CoverageState::TRUE
      @info.elems[3].state = CoverageState::NONE
      @e.children_and_self_state(@info).should == CoverageState::NONE
    end

    it 'should be CoverageState::FALSE' do
      @info.elems[0].state = CoverageState::BOTH
      @info.elems[1].state = CoverageState::BOTH
      @info.elems[2].state = CoverageState::FALSE
      @info.elems[3].state = CoverageState::FALSE
      @e.children_and_self_state(@info).should == CoverageState::FALSE
    end

    it 'should be CoverageState::TRUE' do
      @info.elems[0].state = CoverageState::BOTH
      @info.elems[1].state = CoverageState::BOTH
      @info.elems[2].state = CoverageState::TRUE
      @info.elems[3].state = CoverageState::TRUE
      @e.children_and_self_state(@info).should == CoverageState::TRUE
    end

    it 'should be CoverageState::BOTH' do
      @info.elems[0].state = CoverageState::BOTH
      @info.elems[1].state = CoverageState::BOTH
      @info.elems[2].state = CoverageState::BOTH
      @info.elems[3].state = CoverageState::BOTH
      @e.children_and_self_state(@info).should == CoverageState::BOTH
    end
  end

  context 'get state of children | self' do
    it 'should be CoverageState::NONE' do
      @info.elems[0].state = CoverageState::BOTH
      @info.elems[1].state = CoverageState::FALSE
      @info.elems[2].state = CoverageState::TRUE
      @info.elems[3].state = CoverageState::BOTH
      @e.children_or_self_state(@info).should == CoverageState::NONE
    end

    it 'should be CoverageState::FALSE' do
      @info.elems[0].state = CoverageState::NONE
      @info.elems[1].state = CoverageState::FALSE
      @info.elems[2].state = CoverageState::BOTH
      @info.elems[3].state = CoverageState::FALSE
      @e.children_or_self_state(@info).should == CoverageState::FALSE
    end

    it 'should be CoverageState::TRUE' do
      @info.elems[0].state = CoverageState::FALSE
      @info.elems[1].state = CoverageState::TRUE
      @info.elems[2].state = CoverageState::BOTH
      @info.elems[3].state = CoverageState::TRUE
      @e.children_or_self_state(@info).should == CoverageState::TRUE
    end

    it 'should be CoverageState::BOTH' do
      @info.elems[0].state = CoverageState::TRUE
      @info.elems[1].state = CoverageState::BOTH
      @info.elems[2].state = CoverageState::BOTH
      @info.elems[3].state = CoverageState::BOTH
      @e.children_or_self_state(@info).should == CoverageState::BOTH
    end
  end
end


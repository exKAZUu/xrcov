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

describe CoverageElement do
  include CoverageState

  def initialize(*states)
    @info = CoverageInformation.new()
    states.each { |s|
      e = CoverageElement.new(ElementType::BRANCH, "path", [1, 2], "tag", (1...states.size))
      e.state = s
      @info.elems << e
    }
    @e = @info.elems[0]
    @out = Writer.new
  end

  describe '#children_and_self_state' do
    context 'given NONE as state' do
      before do
        initialize(NONE)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq @e.state
      end
    end

    context 'given FALSE as state' do
      before do
        initialize(FALSE)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq @e.state
      end
    end

    context 'given TRUE as state' do
      before do
        initialize(TRUE)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq @e.state
      end
    end

    context 'given BOTH as state' do
      before do
        initialize(BOTH)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq @e.state
      end
    end

    context 'given FALSE, BOTH, TRUE, NONE as states' do
      before do
        initialize(FALSE, BOTH, TRUE, NONE)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq NONE
      end
    end

    context 'given FALSE, BOTH, TRUE, TRUE as states' do
      before do initialize(FALSE, BOTH, TRUE, TRUE)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq NONE
      end
    end

    context 'given FALSE, BOTH, BOTH, BOTH as states' do
      before do initialize(FALSE, BOTH, BOTH, BOTH)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq FALSE
      end
    end

    context 'given TRUE, BOTH, BOTH, BOTH as states' do
      before do initialize(TRUE, BOTH, BOTH, BOTH)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq TRUE
      end
    end

    context 'given BOTH, BOTH, BOTH, BOTH as states' do
      before do initialize(BOTH, BOTH, BOTH, BOTH)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq BOTH
      end
    end
  end

  describe '#children_or_self_state' do
    context 'given NONE as state' do
      before do
        initialize(NONE)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq @e.state
      end
    end

    context 'given FALSE as state' do
      before do
        initialize(FALSE)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq @e.state
      end
    end

    context 'given TRUE as state' do
      before do
        initialize(TRUE)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq @e.state
      end
    end

    context 'given BOTH as state' do
      before do
        initialize(BOTH)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq @e.state
      end
    end

    context 'given FALSE, BOTH, TRUE, NONE as states' do
      before do
        initialize(FALSE, BOTH, TRUE, NONE)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq NONE
      end
    end

    context 'given FALSE, BOTH, TRUE, TRUE as states' do
      before do initialize(FALSE, BOTH, TRUE, TRUE)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq TRUE
      end
    end

    context 'given FALSE, BOTH, BOTH, BOTH as states' do
      before do initialize(FALSE, BOTH, BOTH, BOTH)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq BOTH
      end
    end

    context 'given TRUE, BOTH, BOTH, BOTH as states' do
      before do initialize(TRUE, BOTH, BOTH, BOTH)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq BOTH
      end
    end

    context 'given BOTH, BOTH, BOTH, BOTH as states' do
      before do initialize(BOTH, BOTH, BOTH, BOTH)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq BOTH
      end
    end
  end

  describe '#write and #read' do
    before do
      @e = CoverageElement.new(ElementType::CONDITION, "/p", [2, 0], "", (1...2))
      @e2 = CoverageElement.read(@e.write(@out))
    end

    it 'restore itself' do
      @e.type.should == @e2.type
      @e.path.should == @e2.path
      @e.pos.should == @e2.pos
      @e.tag.should == @e2.tag
      @e.state.should == @e2.state
      @e.child_range.should == @e2.child_range
    end
  end
end

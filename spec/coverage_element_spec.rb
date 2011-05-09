require 'spec_helper'

class Writer
  def initialize()
    @arr = []
  end

  def write(*o)
    o
  end
end

describe CoverageElement do

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
    context 'given N as state' do
      before do
        initialize(N)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq @e.state
      end
    end

    context 'given F as state' do
      before do
        initialize(F)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq @e.state
      end
    end

    context 'given T as state' do
      before do
        initialize(T)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq @e.state
      end
    end

    context 'given B as state' do
      before do
        initialize(B)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq @e.state
      end
    end

    context 'given F, B, T, N as states' do
      before do
        initialize(F, B, T, N)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq N
      end
    end

    context 'given F, B, T, T as states' do
      before do initialize(F, B, T, T)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq N
      end
    end

    context 'given F, B, B, B as states' do
      before do initialize(F, B, B, B)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq F
      end
    end

    context 'given T, B, B, B as states' do
      before do initialize(T, B, B, B)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq T
      end
    end

    context 'given B, B, B, B as states' do
      before do initialize(B, B, B, B)
      end

      it 'gets value of logical multiply between states of children and itself' do
        @e.children_and_self_state(@info).should eq B
      end
    end
  end

  describe '#children_or_self_state' do
    context 'given N as state' do
      before do
        initialize(N)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq @e.state
      end
    end

    context 'given F as state' do
      before do
        initialize(F)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq @e.state
      end
    end

    context 'given T as state' do
      before do
        initialize(T)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq @e.state
      end
    end

    context 'given B as state' do
      before do
        initialize(B)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq @e.state
      end
    end

    context 'given F, B, T, N as states' do
      before do
        initialize(F, B, T, N)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq N
      end
    end

    context 'given F, B, T, T as states' do
      before do initialize(F, B, T, T)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq T
      end
    end

    context 'given F, B, B, B as states' do
      before do initialize(F, B, B, B)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq B
      end
    end

    context 'given T, B, B, B as states' do
      before do initialize(T, B, B, B)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq B
      end
    end

    context 'given B, B, B, B as states' do
      before do initialize(B, B, B, B)
      end

      it 'gets value of logical multiply between states of children or value of its state' do
        @e.children_or_self_state(@info).should eq B
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

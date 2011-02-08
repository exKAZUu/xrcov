require 'spec_helper'

describe CoverageAnalyzer do
  before do
    @anlz = CoverageAnalyzer.new
    @info = CoverageInformation.new
  end

  describe '#analyze_stmt' do
    context 'given S:BOTH, S:NONE, B:BOTH' do
      before do
        @info.elems << CoverageElement.new(ElementType::STATEMENT, "", [0, 0], "")
        @info.elems << CoverageElement.new(ElementType::STATEMENT, "", [1, 1], "")
        @info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "")
        @info.elems[0].state |= CoverageState::BOTH
        @info.elems[2].state |= CoverageState::BOTH
        @cov_count, @all_count = @anlz.analyze_stmt(@info)
      end

      it 'gets the count of covered elements' do
        @cov_count.should eq 1
      end

      it 'gets the count of target elements' do
        @all_count.should eq 2
      end
    end
  end

  describe '#analyze_branch' do
    context 'given S:BOTH, B:NONE, B:TRUE, BC:BOTH' do
      before do
        @info.elems << CoverageElement.new(ElementType::STATEMENT, "", [1, 1], "")
        @info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "")
        @info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "")
        @info.elems << CoverageElement.new(ElementType::BRANCH_AND_CONDITION, "", [1, 1], "")
        @info.elems[0].state |= CoverageState::BOTH
        @info.elems[1].state |= CoverageState::BOTH
        @info.elems[2].state |= CoverageState::TRUE
        @info.elems[3].state |= CoverageState::BOTH
        @cov_count, @all_count = @anlz.analyze_branch(@info)
      end

      it 'gets the count of covered elements' do
        @cov_count.should eq 2
      end

      it 'gets the count of target elements' do
        @all_count.should eq 3
      end
    end
  end

  describe '#analyze_cond' do
    context 'given S:BOTH, B:NONE, B:TRUE, BC:BOTH' do
      before do
        @info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "", (1...3))
        @info.elems << CoverageElement.new(ElementType::CONDITION, "", [1, 1], "")
        @info.elems << CoverageElement.new(ElementType::CONDITION, "", [1, 1], "")
        @info.elems << CoverageElement.new(ElementType::BRANCH_AND_CONDITION, "", [1, 1], "")
        @info.elems[0].state |= CoverageState::TRUE
        @info.elems[1].state |= CoverageState::BOTH
        @info.elems[2].state |= CoverageState::BOTH
        @info.elems[3].state |= CoverageState::BOTH
        @cov_count, @all_count = @anlz.analyze_cond(@info)
      end

      it 'gets the count of covered elements' do
        @cov_count.should eq 2
      end

      it 'gets the count of target elements' do
        @all_count.should eq 2
      end
    end
  end

  describe '#analyze_branch_cond' do
    context 'given B:TRUE, C:BOTH, C:BOTH, BC:BOTH' do
      before do
        @info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "", (1...3))
        @info.elems << CoverageElement.new(ElementType::CONDITION, "", [1, 1], "")
        @info.elems << CoverageElement.new(ElementType::CONDITION, "", [1, 1], "")
        @info.elems << CoverageElement.new(ElementType::BRANCH_AND_CONDITION, "", [1, 1], "")
        @info.elems[0].state |= CoverageState::TRUE
        @info.elems[1].state |= CoverageState::BOTH
        @info.elems[2].state |= CoverageState::BOTH
        @info.elems[3].state |= CoverageState::BOTH
        @cov_count, @all_count = @anlz.analyze_branch_cond(@info)
      end

      it 'gets the count of covered elements' do
        @cov_count.should eq 1
      end

      it 'gets the count of target elements' do
        @all_count.should eq 2
      end
    end
  end

  #context 'running "(stmt_cov(0,0);a=0)"' do
  #  it 'should analyze coverage information' do
  #    stmt_cov(0,0);a=0
  #    @rep.read_all_data('.')
  #    @rep.analyze_stmt().should == [1, 1]
  #  end
  #end
end


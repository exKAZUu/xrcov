require 'spec_helper'

describe CoverageAnalyzer do
  before(:all) do
    @anlz = CoverageAnalyzer.new
  end

  it 'should analyze statement coverage' do
    info = CoverageInformation.new
    info.elems << CoverageElement.new(ElementType::STATEMENT, "", [0, 0], "")
    info.elems << CoverageElement.new(ElementType::STATEMENT, "", [1, 1], "")
    info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "")
    info.elems[0].state |= CoverageState::BOTH
    info.elems[2].state |= CoverageState::BOTH
    @anlz.analyze_stmt(info).should == [1, 2]
  end

  it 'should analyze statement coverage' do
    info = CoverageInformation.new
    info.elems << CoverageElement.new(ElementType::STATEMENT, "", [1, 1], "")
    info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "")
    info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "")
    info.elems << CoverageElement.new(ElementType::BRANCH_AND_CONDITION, "", [1, 1], "")
    info.elems[0].state |= CoverageState::BOTH
    info.elems[1].state |= CoverageState::BOTH
    info.elems[2].state |= CoverageState::TRUE
    info.elems[3].state |= CoverageState::BOTH
    @anlz.analyze_branch(info).should == [2, 3]
  end

  it 'should analyze condition coverage' do
    info = CoverageInformation.new
    info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "", (1...3))
    info.elems << CoverageElement.new(ElementType::CONDITION, "", [1, 1], "")
    info.elems << CoverageElement.new(ElementType::CONDITION, "", [1, 1], "")
    info.elems << CoverageElement.new(ElementType::BRANCH_AND_CONDITION, "", [1, 1], "")
    info.elems[0].state |= CoverageState::TRUE
    info.elems[1].state |= CoverageState::BOTH
    info.elems[2].state |= CoverageState::BOTH
    info.elems[3].state |= CoverageState::BOTH
    @anlz.analyze_cond(info).should == [2, 2]
  end

  it 'should analyze branch/condition coverage' do
    info = CoverageInformation.new
    info.elems << CoverageElement.new(ElementType::BRANCH, "", [1, 1], "", (1...3))
    info.elems << CoverageElement.new(ElementType::CONDITION, "", [1, 1], "")
    info.elems << CoverageElement.new(ElementType::CONDITION, "", [1, 1], "")
    info.elems << CoverageElement.new(ElementType::BRANCH_AND_CONDITION, "", [1, 1], "")
    info.elems[0].state |= CoverageState::TRUE
    info.elems[1].state |= CoverageState::BOTH
    info.elems[2].state |= CoverageState::BOTH
    info.elems[3].state |= CoverageState::BOTH
    @anlz.analyze_branch_cond(info).should == [1, 2]
  end

  #context 'running "(stmt_cov(0,0);a=0)"' do
  #  it 'should analyze coverage information' do
  #    stmt_cov(0,0);a=0
  #    @rep.read_all_data('.')
  #    @rep.analyze_stmt().should == [1, 1]
  #  end
  #end
end


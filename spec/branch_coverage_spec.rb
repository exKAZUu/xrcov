require 'spec_helper'

B = ElementType::BRANCH
C = ElementType::CONDITION
BC = ElementType::BRANCH_AND_CONDITION

describe CoverageInserter, 'when it inserts "b" method into branches of ' do
  before {
    def subject.insert_coverage(src)
      @ast = Ripper::RubyBuilder.build(src)
      insert_branch_coverage('b')
      @ast.to_ruby
    end
  }

  it 'into "if true then end"' do
    subject.insert_coverage('if true then end').should eq "if b(0,#{BC},(true)) then end"
    subject.info.elems.count.should eq 1
    subject.info.elems[0].child_range.count.should eq 0
  end

  it 'into "if (true && true and true || true or true) then end"' do
    subject.insert_coverage('if (true && true and true || true or true) then end').should eq "if b(5,#{B},((b(1,#{C},(true)) && b(2,#{ElementType::CONDITION},(true)) and b(3,#{ElementType::CONDITION},(true)) || b(4,#{ElementType::CONDITION},(true)) or b(0,#{ElementType::CONDITION},(true))))) then end"
    subject.info.elems.count.should eq 6
    subject.info.elems[0].child_range.count.should eq 0
    subject.info.elems[1].child_range.count.should eq 0
    subject.info.elems[2].child_range.count.should eq 0
    subject.info.elems[3].child_range.count.should eq 0
    subject.info.elems[4].child_range.count.should eq 0
    subject.info.elems[5].child_range.count.should eq 4
  end
end


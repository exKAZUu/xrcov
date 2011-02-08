require 'spec_helper'

describe BranchCoverage do
  describe '#insert_branch_coverage' do
    before do
      @ins = CoverageInserter.new
      def @ins.insert_coverage(src)
        @ast = Ripper::RubyBuilder.build(src)
        insert_branch_coverage('b')
        @ast.to_ruby
      end
    end

    context 'given "if true then end"' do
      before do
        @ret = @ins.insert_coverage('if true then end')
      end

      it 'gets a inserted source code' do
        @ret.should eq "if b(0,#{BC},(true)) then end"
      end

      it 'gets coveraged elements' do
        @ins.info.elems.count.should eq 1
        @ins.info.elems[0].child_range.count.should eq 0
      end
    end

    context 'given "if (true && true and true || true or true) then end"' do
      before do
        @ret = @ins.insert_coverage('if (true && true and true || true or true) then end')
      end

      it 'gets a inserted source code' do
        @ret.should eq "if b(5,#{B},((b(1,#{C},(true)) && b(2,#{ElementType::CONDITION},(true)) and b(3,#{ElementType::CONDITION},(true)) || b(4,#{ElementType::CONDITION},(true)) or b(0,#{ElementType::CONDITION},(true))))) then end"
      end

      it 'gets coveraged elements' do
        @ins.info.elems.count.should eq 6
        @ins.info.elems[0].child_range.count.should eq 0
        @ins.info.elems[1].child_range.count.should eq 0
        @ins.info.elems[2].child_range.count.should eq 0
        @ins.info.elems[3].child_range.count.should eq 0
        @ins.info.elems[4].child_range.count.should eq 0
        @ins.info.elems[5].child_range.count.should eq 4
      end
    end
  end
end

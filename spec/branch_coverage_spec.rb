require 'spec_helper'

describe BranchCoverage do
  describe '#insert_branch_coverage' do
    before do
      @ins = CoverageInserter.new('fixture')
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
        @ret.should eq "if b(5,#{BR},((b(1,#{CO},(true)) && b(2,#{CO},(true)) and b(3,#{CO},(true)) || b(4,#{CO},(true)) or b(0,#{CO},(true))))) then end"
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

require 'spec_helper'

describe StatementCoverage do
  describe '#insert_statement_coverage' do
    before do
      @ins = CoverageInserter.new('fixture')
      def @ins.insert_coverage(src)
        @ast = Ripper::RubyBuilder.build(src)
        insert_statement_coverage('s')
        @ast.to_ruby
      end
    end

    context 'given "a = 0"' do
      before do
        @ret = @ins.insert_coverage('a = 0')
      end

      it 'gets a inserted source code' do
        @ret.should eq "(s(0,#{ST});a = 0)"
      end

      it 'gets coveraged elements' do
        @ins.info.elems.count.should eq 1
        @ins.info.elems[0].child_range.count.should eq 0
      end
    end

    context 'given "a=0;b=1"' do
      before do
        @ret = @ins.insert_coverage('a=0;b=1')
      end

      it 'gets a inserted source code' do
        @ret.should eq "(s(0,#{ST});a=0);(s(1,#{ST});b=1)"
      end

      it 'gets coveraged elements' do
        @ins.info.elems.count.should eq 2
        @ins.info.elems[0].child_range.count.should eq 0
        @ins.info.elems[1].child_range.count.should eq 0
      end
    end

    context 'given "if true then end"' do
      before do
        @ret = @ins.insert_coverage('if true then end')
      end

      it 'gets a inserted source code' do
        @ret.should eq "(s(0,#{ST});if true then end)"
      end

      it 'gets coveraged elements' do
        @ins.info.elems.count.should eq 1
        @ins.info.elems[0].child_range.count.should eq 0
      end
    end

    context 'given "loop do end"' do
      before do
        @ret = @ins.insert_coverage('loop do end')
      end

      it 'gets a inserted source code' do
        @ret.should eq "(s(0,#{ST});loop do end)"
      end

      it 'gets coveraged elements' do
        @ins.info.elems.count.should eq 1
        @ins.info.elems[0].child_range.count.should eq 0
      end
    end

    context 'given "while true do break if true end"' do
      before do
        @ret = @ins.insert_coverage('while true do break if true end')
      end

      it 'gets a inserted source code' do
        @ret.should eq "(s(0,#{ST});while true do (s(1,#{ST});(s(2,#{ST});break) if true) end)"
      end

      it 'gets coveraged elements' do
        @ins.info.elems.count.should eq 3
        @ins.info.elems[0].child_range.count.should eq 0
        @ins.info.elems[1].child_range.count.should eq 0
        @ins.info.elems[2].child_range.count.should eq 0
      end
    end
  end
end

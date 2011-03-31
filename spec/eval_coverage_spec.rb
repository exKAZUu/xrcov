require 'spec_helper'

describe EvalCoverage do
  describe '#insert_branch_coverage' do
    before do
      @ins = CoverageInserter.new('fixture')
      def @ins.insert_coverage(src)
        @ast = Ripper::RubyBuilder.build(src)
        insert_eval_coverage('e')
        @ast.to_ruby
      end
    end

    context 'given two simple evals' do
      before do
        @ret = @ins.insert_coverage %q!
          eval "3+4" #=> 7
          eval "def multiply(x,y) ; x*y; end"
          multiply(4,7) #=> 28!
      end

      it 'gets a inserted source code' do
        @ret.should eq %q!
          eval e(0,("3+4")) #=> 7
          eval e(1,("def multiply(x,y) ; x*y; end"))
          multiply(4,7) #=> 28!
      end
    end
  end
end

require 'spec_helper'

describe EvalCoverage do
  before(:each) do
    @tester = CoverageInserter.new()
    def @tester.insert_coverage(src)
      @ast = Ripper::RubyBuilder.build(src)
      insert_eval_coverage('e')
      @ast.to_ruby
    end
  end

  it 'should insert eval_cov in all eval functions' do
    @tester.insert_coverage(%q!
   eval "3+4" #=> 7
   eval "def multiply(x,y) ; x*y; end"
   multiply(4,7) #=> 28
    !).should == %q!
   eval e(0,("3+4")) #=> 7
   eval e(1,("def multiply(x,y) ; x*y; end"))
   multiply(4,7) #=> 28!
  end
end

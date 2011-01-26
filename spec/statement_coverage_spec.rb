require 'spec_helper'

T = ElementType::STATEMENT

describe StatementCoverage do
  before(:each) do
    @tester = CoverageInserter.new()
    def @tester.insert_coverage(src)
      @ast = Ripper::RubyBuilder.build(src)
      insert_statement_coverage('s')
      @ast.to_ruby
    end
  end

  context 'a = 0' do
    it 'should insert measurement code' do
      @tester.insert_coverage('a = 0').should == "(s(0,#{T});a = 0)"
      @tester.info.elems.count.should == 1
    end
  end

  context 'a=0;b=1' do
    it 'should insert measurement code' do
      @tester.insert_coverage('a=0;b=1').should == "(s(0,#{T});a=0);(s(1,#{T});b=1)"
      @tester.info.elems.count.should == 2
    end
  end

  context 'if true then end' do
    it 'should insert measurement code' do
      @tester.insert_coverage('if true then end').should == "(s(0,#{T});if true then end)"
      @tester.info.elems.count.should == 1
    end
  end

  context 'loop do end' do
    it 'should insert measurement code' do
      @tester.insert_coverage('loop do end').should == "(s(0,#{T});loop do end)"
      @tester.info.elems.count.should == 1
    end
  end

  context 'while true do break if true end' do
    it 'should insert measurement code' do
      @tester.insert_coverage('while true do break if true end').should == "(s(0,#{T});while true do (s(1,#{T});(s(2,#{T});break) if true) end)"
      @tester.info.elems.count.should == 3
    end
  end
end

require 'spec_helper'

describe CoverageInserter do
  IN_PATH = 'fixture/input'
  OUT_PATH = 'fixture/output'
  before(:each) do
    FileUtils.rm_r(OUT_PATH, :force => true)
    FileUtils.mkdir(OUT_PATH)
    @info = CoverageInserter.new(OUT_PATH)
  end

  describe '#insert_coverage_in_file' do
    context 'given sample.rb' do
      NAME = 'sample.rb'
      PATH = File.join(OUT_PATH, NAME)

      it 'inserts measurement code' do
        FileUtils.cp(File.join(IN_PATH, NAME), PATH)
        ret = @info.insert_coverage_in_file(PATH)
        #exp = File.open(PATH + '.exp') { |f| f.read() }
        #ret.should eq exp
      end
    end
  end
end


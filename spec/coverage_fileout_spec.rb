require 'spec_helper'

describe 'coverage_fileout.rb' do
  IN_PATH = 'fixture/input'
  OUT_PATH = $xrcov_out_path = 'fixture/output'

  before(:each) do
    FileUtils.rm_r(OUT_PATH, :force => true)
    FileUtils.mkdir(OUT_PATH)
    @src_name = 'sample.rb'
    @src_path = File.join(OUT_PATH, @src_name)
    FileUtils.cp(File.join(IN_PATH, @src_name), @src_path)
    @ins = CoverageInserter.new(OUT_PATH)
    @ins.insert_coverage_in_file(@src_path)
    require 'xrcov/coverage_fileout'
    XrcovOut.initialize() if XrcovOut.out.file.closed?
    @out_file_path = File.join(OUT_PATH, CoverageInserter::OUT_SUFFIX)
  end

  describe '#stmt_cov' do
    context 'given 0, 0' do
      it 'writes data' do
        XrcovOut.stmt(0, 0)
        XrcovOut.out.file.close()
        File.open(@out_file_path,'r') { |f|
          f.readline.should eq "0\t0\t3\n"
        } 
      end
    end

    context 'given 0, 0 and 1, 1' do
      it 'writes data' do
        XrcovOut.stmt(0, 0)
        XrcovOut.stmt(1, 1)
        XrcovOut.out.file.close()
        File.open(@out_file_path,'r') { |f|
          f.readline.should eq "0\t0\t3\n"
          f.readline.should eq "1\t1\t3\n"
        } 
      end
    end
  end
end

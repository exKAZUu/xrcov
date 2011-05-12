require 'spec_helper'

describe CoverageInserter do

  before(:all) do
    FileUtils.rm_r(OUT_DIR, {:force => true})
    FileUtils.mkdir(OUT_DIR)
  end

  def copy_files(dir_name)
    in_dir = File.join(IN_DIR, dir_name)
    FileUtils.cp_r(in_dir, OUT_DIR)
  end

  def assert_insert(dir_name)
    copy_files(dir_name)
    out_dir = File.join(OUT_DIR, dir_name, 'lib')
    CoverageInserter.insert_coverage(out_dir)
    exp_dir = File.join(EXP_DIR, dir_name, 'lib')
    files = Dir[File.join(out_dir, '**/*')]
    files.each { |path|
      next unless File.file?(path)
      act = File.open(path, 'r') { |f| f.read() }
      name = File.basename(path)
      exp_path = File.join(exp_dir, name)
      exp = File.open(exp_path, 'r') { |f| f.read() }
      act.should eq exp
    }
  end

  describe '#insert_coverage_in_file' do
    context 'given sample' do
      it 'inserts measurement code' do
        assert_insert 'sample'
      end
    end

    context 'given stmt' do
      it 'inserts measurement code' do
        assert_insert 'stmt'
      end
    end

    context 'given branch' do
      it 'inserts measurement code' do
        assert_insert 'branch'
      end
    end

    context 'given fibonacci' do
      it 'inserts measurement code' do
        assert_insert 'fibonacci'
      end
    end

    context 'given prolog' do
      it 'inserts measurement code' do
        assert_insert 'prolog'
      end
    end
  end
end


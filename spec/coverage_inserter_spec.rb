require 'spec_helper'

describe CoverageInserter do
  IN_DIR = 'fixture/input'
  EXP_DIR = 'fixture/expected'
  OUT_DIR = 'fixture/output'

  before(:all) do
    FileUtils.rm_f(OUT_DIR)
  end

  def copy_files(dir_name)
    in_dir = File.join(IN_DIR, dir_name)
    FileUtils.cp_r(in_dir, OUT_DIR)
  end

  def assert_insert(dir_name)
    copy_files(dir_name)
    out_dir = File.join(OUT_DIR, dir_name)
    CoverageInserter.insert_coverage(out_dir)
    exp_dir = File.join(EXP_DIR, name)
    Find.find(exp_dir) { |exp_path|
      exp = File.open(exp_path) { |f| f.read() }
      name = File.basename(exp_path)
      out_path = File.join(OUT_DIR, name)
      act = File.open(out_path) { |f| f.read() }
      act.should eq exp
    }
  end

  describe '#insert_coverage_in_file' do
    context 'given stmt' do
      it 'inserts measurement code' do
        assert_insert 'stmt'
      end
    end

    context 'given sample' do
      it 'inserts measurement code' do
        assert_insert 'sample'
      end
    end

    context 'given branch' do
      it 'inserts measurement code' do
        assert_insert 'branch'
      end
    end
  end
end


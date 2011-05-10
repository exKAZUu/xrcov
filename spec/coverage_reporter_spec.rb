require 'spec_helper'

describe CoverageReporter do
  before(:all) do
    FileUtils.rm_r(OUT_DIR, {:force => true})
    FileUtils.mkdir(OUT_DIR)
  end

  def copy_files(dir_name)
    in_dir = File.join(EXP_DIR, dir_name)
    FileUtils.cp_r(in_dir, OUT_DIR)
  end

  def assert_report(dir_name, *expected)
    reporter = CoverageReporter.new

    # Run inserted program
    copy_files(dir_name)
    path = File.join(OUT_DIR, dir_name)
    system "cd #{path}; rspec spec"

    path = File.join(OUT_DIR, dir_name, 'lib')
    actual = reporter.print_result(path)
    actual.should eq expected
  end

  describe '#show' do
    context 'given sample' do
      it 'report coverage result' do
        assert_report('sample',
                      [20, 24], [0, 4], [2, 4], [0, 4])
      end
    end

    context 'given stmt' do
      it 'report coverage result' do
        assert_report('stmt',
                      [7, 7], [0, 0], [0, 0], [0, 0])
      end
    end

    context 'given branch' do
      it 'report coverage result' do
        assert_report('branch',
                      [5, 6], [0, 1], [0, 1], [0, 1])
      end
    end

    context 'given fibonacci' do
      it 'report coverage result' do
        assert_report('fibonacci',
                      [13, 13], [0, 0], [0, 0], [0, 0])
      end
    end
  end
end

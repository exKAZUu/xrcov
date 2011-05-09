require 'spec_helper'

describe TsvStream do
  FILE_NAME = 'test.tsv'

  def assert_write_and_read(*records)
    open(FILE_NAME, 'w') { |f|
      s = TsvStream.new(f)
      records.each { |record|
        s.write(*record)
      }
    }
    act_records = []
    open(FILE_NAME, 'r') { |f|
      TsvStream.new(f).read_all { |record|
        act_records << record
      }
    }
    act_records.should eq records
  end

  describe '#write and read_all' do
    context 'given ["abc"]' do
      it 'restore wrote records' do
        assert_write_and_read(['abc'])
      end
    end

    context 'given ["abc" , " a / "]' do
      it 'restore wrote records' do
        assert_write_and_read(['abc', ' a / '])
      end
    end

    context 'given ["abc"], ["abc"]' do
      it 'restore wrote records' do
        assert_write_and_read(['abc'], ['abc'])
      end
    end

    context 'given ["abc" , " a / "], ["abc"]' do
      it 'restore wrote records' do
        assert_write_and_read(['abc', ' a / '], ['abc'])
      end
    end

    context 'given ["abc"], ["+*%", "  "]' do
      it 'restore wrote records' do
        assert_write_and_read(['abc'], ['+*%', '  '])
      end
    end
  end
end


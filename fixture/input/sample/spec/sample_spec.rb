require 'sample'

describe Sample do
  describe '#test' do
    context 'given 1' do
      it 'run' do
        Sample.new.test 1
      end
    end
  end
end

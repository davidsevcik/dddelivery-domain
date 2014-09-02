require 'spec_helper'
require 'dddelivery'

describe Dddelivery do
  before :all do
    class Dddelivery
      class Foo
        class Bar; end
      end
    end
  end

  describe '#lookup' do
    it 'returns domain class' do
      expect(subject.lookup(:foo, :bar)).to be(Dddelivery::Foo::Bar)
    end
  end

  describe '#[]' do
    it 'returns domain class' do
      expect(subject[:foo, :bar]).to be(Dddelivery::Foo::Bar)
    end
  end

  context 'with adapter' do
    describe '#lookup' do
      it 'returns domain class' do
        test_adapter = double('test_adapter')
        expect(test_adapter).to receive(:adapt).with(Dddelivery::Foo::Bar) { :wrapped_class }
        subject.use_adapter :foo, :bar, test_adapter
        expect(subject.lookup(:foo, :bar)).to eq(:wrapped_class)
      end
    end
  end
end

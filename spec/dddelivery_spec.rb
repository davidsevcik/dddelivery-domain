require 'spec_helper'
require 'dddelivery'

describe Dddelivery do

  describe '#lookup' do
    it 'returns domain class' do
      expect(subject.lookup(:product)).to be(Dddelivery::Product)
    end
  end

  describe '#[]' do
    it 'returns domain class' do
      expect(subject[:product]).to be(Dddelivery::Product)
    end
  end

  context 'with adapter' do
    describe '#lookup' do
      it 'returns domain class' do
        test_adapter = double('test_adapter')
        expect(test_adapter).to receive(:wrap).with(Dddelivery::Product) { :wrapped_class }
        subject.use_adapter :product, test_adapter
        expect(subject.lookup(:product)).to eq(:wrapped_class)
      end
    end
  end
end


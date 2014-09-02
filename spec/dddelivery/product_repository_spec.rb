require 'spec_helper'
require 'dddelivery'
require 'dddelivery/product_repository'
require 'test_adapters/test_repository_adapter'

describe Dddelivery::ProductRepository do

  context 'using test ArrayStoreAdapter' do
    let(:domain) do
      Dddelivery.new.tap do |domain|
        domain.use_adapter :product_repository, TestRepositoryAdapter
      end
    end

    let(:product) { double(:product, id: 123) }
    subject { domain[:product_repository].new }

    describe '#save' do
      it 'saves a product record' do
        expect(subject.save(product)).to be_truthy
      end
    end

    describe '#find_by_id' do
      context 'product is not in repository' do
        it 'returns nil' do
          expect(subject.find_by_id(123)).to be_nil
        end
      end

      context 'product is in repository' do
        it 'returns product' do
          subject.save(product)
          expect(subject.find_by_id(123)).to eq(product)
        end
      end
    end
  end

end

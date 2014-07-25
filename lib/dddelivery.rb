require 'active_support/all'

require 'dddelivery/product'
require 'dddelivery/order'
require 'dddelivery/product_repository'
require 'dddelivery/order_repository'
require 'dddelivery/place_order_service'


class Dddelivery

  attr_reader :adapters

  def initialize(adapters = [])
    @adapters = adapters
  end

  def [](domain_object_name)
    klass = domain_object_name.to_s.classify.constantize
    adapters.each do |adapter|
      klass = adapter.wrap(klass) if adapter.use_for?(klass)
    end
    klass
  end
end

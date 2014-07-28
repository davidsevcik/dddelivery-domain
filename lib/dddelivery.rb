require 'active_support/all'

require 'dddelivery/product'
require 'dddelivery/order'
require 'dddelivery/product_repository'
require 'dddelivery/order_repository'
require 'dddelivery/place_order_service'


class Dddelivery

  attr_reader :adapters

  def initialize
    @adapters = {}
  end

  def use_adapter(*args)
    adapter = args.slice!(-1)
    class_name = 'Dddelivery::' + args.map {|arg| arg.to_s.classify }.join('::')
    klass = class_name.constantize
    @adapters[klass] = Array(@adapters[klass]) + [adapter]
  end

  def lookup(*domain_names)
    klass = ('Dddelivery::' + domain_names.map {|name| name.to_s.classify }.join('::') ).constantize
    Array(adapters[klass]).each do |adapter|
      klass = adapter.wrap(klass)
    end
    klass
  end

  alias_method :[], :lookup
end

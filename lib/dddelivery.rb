require 'active_support/core_ext/string/inflections'

class Dddelivery

  attr_reader :adapters

  def initialize
    @adapters = {}
  end

  def use_adapter(*args)
    adapter = args.slice!(-1)
    class_name = 'Dddelivery::' + args.map {|arg| arg.to_s.classify }.join('::')
    klass = class_name.constantize
    (@adapters[klass] ||= []) << adapter
  end

  def lookup(*domain_names)
    klass = ('Dddelivery::' + domain_names.map {|name| name.to_s.classify }.join('::') ).constantize
    Array(adapters[klass]).each do |adapter|
      klass = adapter.adapt(klass)
    end
    klass
  end

  alias_method :[], :lookup
end

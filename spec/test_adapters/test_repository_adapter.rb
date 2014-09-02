require 'active_support/core_ext/object/try'
require 'set'

class TestRepositoryAdapter

  def self.adapt(repository_class)
    Class.new(repository_class) do
      def initialize
        @store = Set.new
        super
      end

      def save(product)
        @store << product
        true
      end

      def find_by_id(product)
        id = product.try(:id) || Integer(product)
        @store.find {|prod| prod.id == id }
      end
    end
  end
end

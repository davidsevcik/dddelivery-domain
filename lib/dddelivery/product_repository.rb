class Dddelivery
  class ProductRepository
    @store = []

    def persist(product)
      @store << product
    end

    def find_by_id(product)
      id = product.try(:id) || Integer(product)
      @store.find {|prod| prod.id == id }
    end

    def store

    end
  end
end

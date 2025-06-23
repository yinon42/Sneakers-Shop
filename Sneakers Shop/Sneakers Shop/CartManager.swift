import SwiftUI

class CartManager: ObservableObject {
    @Published var products: [Product: Int] = [:]

    var total: Double {
        products.reduce(0) { $0 + ($1.key.price * Double($1.value)) }
    }

    func totalQuantity() -> Int {
        products.values.reduce(0, +)
    }

    func addToCart(product: Product) {
        products[product, default: 0] += 1
    }

    func removeFromCart(product: Product) {
        if let count = products[product], count > 1 {
            products[product] = count - 1
        } else {
            products.removeValue(forKey: product)
        }
    }

    func clearCart() {
        products.removeAll()
    }

    func getItemsArray() -> [[String: Any]] {
        return products.map { product, quantity in
            [
                "id": product.id,
                "name": product.name,
                "brand": product.brand,
                "price": product.price,
                "image": product.image,
                "quantity": quantity
            ]
        }
    }
}

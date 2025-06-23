import Foundation

struct CartItem: Identifiable {
    var id: String { product.id }
    var product: Product
    var quantity: Int
}

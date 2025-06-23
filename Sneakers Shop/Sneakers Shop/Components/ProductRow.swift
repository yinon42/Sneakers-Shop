import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    var quantity: Int

    var body: some View {
        HStack(spacing: 20) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .cornerRadius(15)

            VStack(alignment: .leading, spacing: 6) {
                Text(product.name)
                    .font(.headline)
                Text("Brand: \(product.brand)")
                    .font(.subheadline)
                Text("Quantity: \(quantity)")
                    .font(.subheadline)
            }

            Spacer()

            VStack {
                Text("$\(product.price * Double(quantity), specifier: "%.2f")")
                    .bold()
                Button(action: {
                    cartManager.removeFromCart(product: product)
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

import SwiftUI
import Firebase
import FirebaseAuth


struct CartView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        VStack(alignment: .leading) {
            Text("My Cart")
                .font(.largeTitle)
                .bold()
                .padding(.bottom)

            if cartManager.products.isEmpty {
                Text("Your cart is empty.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(Array(cartManager.products.keys), id: \.self) { product in
                        let quantity = cartManager.products[product] ?? 0

                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text("Brand: \(product.brand)")
                                    .font(.subheadline)
                                Text("Quantity: \(quantity)")
                                    .font(.subheadline)
                            }

                            Spacer()

                            Text("$\(product.price * Double(quantity), specifier: "%.2f")")

                            Button(action: {
                                cartManager.removeFromCart(product: product)
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }

                Text("Total: $\(cartManager.total, specifier: "%.2f")")
                    .font(.title2)
                    .bold()
                    .padding()

                
                Button(action: {
                    placeOrder()
                }) {
                    Text("💳 Pay Now")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
        }
        .padding()
    }

    func placeOrder() {
        guard let user = Auth.auth().currentUser else { return }

        let orderData: [String: Any] = [
            "userId": user.uid,
            "items": cartManager.getItemsArray(),
            "timestamp": Timestamp(date: Date()),
            "totalPrice": cartManager.total
        ]

        Firestore.firestore().collection("orders").addDocument(data: orderData) { error in
            if let error = error {
                print("❌ Failed to save order: \(error.localizedDescription)")
            } else {
                print("✅ Order saved successfully")
                cartManager.clearCart()
            }
        }
    }
}

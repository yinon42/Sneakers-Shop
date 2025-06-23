import SwiftUI

struct OrdersView: View {
    @ObservedObject var firebaseManager = FirebaseManager()

    var body: some View {
        NavigationView {
            List {
                ForEach(firebaseManager.orders) { order in
                    Section(header: Text("Order on \(order.timestamp.formatted(date: .abbreviated, time: .shortened))")) {
                        ForEach(order.items) { product in
                            HStack {
                                Image(product.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.headline)
                                    Text(product.brand)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                Text(String(format: "$%.2f", product.price))
                                    .bold()
                            }
                        }

                        HStack {
                            Spacer()
                            Text("Total: $\(order.totalPrice, specifier: "%.2f")")
                                .bold()
                        }
                    }
                }
            }
            .navigationTitle("My Orders")
        }
    }
}

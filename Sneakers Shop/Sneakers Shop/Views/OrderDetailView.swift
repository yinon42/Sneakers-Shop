import SwiftUI
import FirebaseFirestore

struct OrderDetailView: View {
    var order: [String: Any]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            if let timestamp = order["timestamp"] as? Timestamp {
                let date = timestamp.dateValue()
                Text("📅 Order Date: \(date.formatted(date: .long, time: .shortened))")
                    .font(.subheadline)
            }

            if let total = order["totalPrice"] as? Double {
                Text("💰 Total: \(String(format: "$%.2f", total))")
                    .font(.headline)
                    .padding(.bottom, 10)
            }

            Divider()

            if let items = order["items"] as? [[String: Any]] {
                List(items.indices, id: \.self) { index in
                    let item = items[index]

                    HStack(alignment: .center, spacing: 16) {
                        if let imageName = item["image"] as? String {
                            Image(imageName)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                        }

                        VStack(alignment: .leading) {
                            Text(item["name"] as? String ?? "Unknown")
                                .font(.headline)

                            Text(item["brand"] as? String ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            if let price = item["price"] as? Double,
                               let quantity = item["quantity"] as? Int {
                                Text(String(format: "$%.2f", price * Double(quantity)))
                                    .font(.subheadline)
                                    .foregroundColor(.blue)

                                Text("Quantity: \(quantity)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
                .listStyle(PlainListStyle())
            } else {
                Text("No items in this order.")
                    .padding()
            }
        }
        .padding()
        .navigationTitle("Order Details")
    }
}

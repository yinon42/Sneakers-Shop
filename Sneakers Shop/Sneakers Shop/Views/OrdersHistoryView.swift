import SwiftUI
import FirebaseFirestore

struct OrdersHistoryView: View {
    @State private var orders: [[String: Any]] = []

    var body: some View {
        List {
            if orders.isEmpty {
                Text("You have no past orders.")
                    .foregroundColor(.gray)
            } else {
                ForEach(orders.indices, id: \.self) { index in
                    let order = orders[index]
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Order #\(index + 1)")
                                .font(.headline)
                            if let total = order["total"] as? Double {
                                Text(String(format: "Total: $%.2f", total))
                            }
                            if let timestamp = order["timestamp"] as? String {
                                Text("Date: \(timestamp)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                    }

                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("My Orders")
        .onAppear(perform: fetchOrders)
    }

    private func fetchOrders() {
        let db = Firestore.firestore()
        db.collection("orders").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Failed to fetch orders: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else { return }

            self.orders = documents.compactMap { doc in
                var data = doc.data()
                data["id"] = doc.documentID
                return data
            }
        }
    }
}

struct OrdersHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersHistoryView()
    }
}

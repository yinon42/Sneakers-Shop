import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct FirebaseConstants {
    static let orders = "orders"
    static let userId = "userId"
    static let items = "items"
    static let totalPrice = "totalPrice"
    static let timestamp = "timestamp"
}

struct Order: Identifiable {
    let id: String
    let userId: String
    let items: [Product]
    let totalPrice: Double
    let timestamp: Date
}

class FirebaseManager: NSObject, ObservableObject {
    @Published var orders: [Order] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    let auth: Auth
    let storage: Storage
    let firestore: Firestore

    static let shared = FirebaseManager()

    override init() {
    
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        super.init()
    }

    func saveOrder(cartProducts: [Product], total: Double) {
        guard let userId = auth.currentUser?.uid else {
            self.errorMessage = "⚠️ No authenticated user."
            return
        }

        let orderData: [String: Any] = [
            FirebaseConstants.userId: userId,
            FirebaseConstants.totalPrice: total,
            FirebaseConstants.timestamp: Timestamp(date: Date()),
            FirebaseConstants.items: cartProducts.map { product in
                return [
                    "id": product.id,
                    "name": product.name,
                    "brand": product.brand,
                    "price": product.price,
                    "image": product.image
                ]
            }
        ]

        firestore.collection(FirebaseConstants.orders).addDocument(data: orderData) { error in
            if let error = error {
                self.errorMessage = "🛑 Failed to save order: \(error.localizedDescription)"
            } else {
                print("✅ Order saved successfully.")
                self.fetchOrders()
            }
        }
    }

    func fetchOrders() {
        guard let userId = auth.currentUser?.uid else {
            self.errorMessage = "⚠️ No authenticated user."
            return
        }

        isLoading = true

        firestore.collection(FirebaseConstants.orders)
            .whereField(FirebaseConstants.userId, isEqualTo: userId)
            .order(by: FirebaseConstants.timestamp, descending: true)
            .getDocuments { snapshot, error in
                self.isLoading = false

                if let error = error {
                    self.errorMessage = "🛑 Failed to fetch orders: \(error.localizedDescription)"
                    return
                }

                self.orders = snapshot?.documents.compactMap { doc -> Order? in
                    let data = doc.data()
                    guard let totalPrice = data[FirebaseConstants.totalPrice] as? Double,
                          let timestamp = data[FirebaseConstants.timestamp] as? Timestamp,
                          let itemsData = data[FirebaseConstants.items] as? [[String: Any]] else {
                        return nil
                    }

                    let items = itemsData.compactMap { dict -> Product? in
                        guard let id = dict["id"] as? String,
                              let name = dict["name"] as? String,
                              let brand = dict["brand"] as? String,
                              let price = dict["price"] as? Double,
                              let image = dict["image"] as? String else {
                            return nil
                        }

                        return Product(id: id, name: name, brand: brand, price: price, image: image)
                    }

                    return Order(id: doc.documentID, userId: userId, items: items, totalPrice: totalPrice, timestamp: timestamp.dateValue())
                } ?? []
            }
    }
}

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var cartManager: CartManager
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true

    let columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(productList, id: \.id) { sneaker in
                            ProductCard(product: sneaker)
                                .environmentObject(cartManager)
                        }
                    }
                    .padding()
                }

                HStack(spacing: 20) {
                    NavigationLink(destination: CartView().environmentObject(cartManager)) {
                        HStack(spacing: 8) {
                            Image("back_ic")
                                .resizable()
                                .frame(width: 24, height: 24)
                            CartButton()
                        }
                    }

                    NavigationLink(destination: OrdersHistoryView()) {
                        Text("🧾 My Orders")
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }

                    Button(action: logout) {
                        Text("🚪 Logout")
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding(.bottom, 16)
            }
            .navigationTitle("Sneakers Shop")
            .background(Color.white)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("❌ Failed to sign out: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartManager())
    }
}

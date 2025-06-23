import SwiftUI
import Firebase
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Auth.auth().useAppLanguage()
        return true
    }
}

@main
struct Sneakers_ShopApp: App {
    @StateObject var cartManager = CartManager()
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false 
    @State private var showLogin = false

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn {
                    ContentView()
                        .environmentObject(cartManager)
                } else {
                    if showLogin {
                        LoginView(isLoggedIn: $isLoggedIn, showLogin: $showLogin)
                    } else {
                        SignUpView(isLoggedIn: $isLoggedIn, showLogin: $showLogin)
                    }
                }
            }
        }
    }
}

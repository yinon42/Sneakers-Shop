import SwiftUI

struct CartButton: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .resizable()
                .frame(width: 24, height: 24)

            if cartManager.totalQuantity() > 0 {
                Text("\(cartManager.totalQuantity())")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton()
            .environmentObject(CartManager())
    }
}

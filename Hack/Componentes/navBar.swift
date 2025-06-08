import SwiftUI

struct Navbar: View {
    @State private var showSustainableSheet = false

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                // Acción para Main
            }) {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.green)
            }
            Spacer()
            Button(action: {
                // Acción para agregar (+)
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.green)
            }
            Spacer()
            Button(action: {
                showSustainableSheet = true
            }) {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.green)
            }
            .sheet(isPresented: $showSustainableSheet) {
                sustainableInfoView()
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
}


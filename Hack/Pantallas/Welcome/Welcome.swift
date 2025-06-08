import SwiftUI

struct Welcome_view: View {
    @State private var offset: CGFloat = 0

    let barCount = 11
    let barWidth: CGFloat = 8
    let barSpacing: CGFloat = 28
    let animationDuration: Double = 2.5

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Fondo degradado
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "#c4ea94"),
                        Color(hex: "#2b7a3c")
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Barras animadas duplicadas
                HStack(spacing: barSpacing) {
                    ForEach(0..<(barCount * 2), id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(hex: "#2c6b3b").opacity(0.08))
                            .frame(width: barWidth, height: geo.size.height + 100)
                            .shadow(color: .black.opacity(0.04), radius: 2, x: 1, y: 1)
                    }
                }
                .frame(width: CGFloat(barCount * 2) * (barWidth + barSpacing))
                .offset(x: offset)
                .onAppear {
                    offset = 0
                    withAnimation(.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
                        offset = -CGFloat(barCount) * (barWidth + barSpacing)
                    }
                }

                // Logo + botón completamente centrados
                VStack(spacing: 28) {
                    Text("EcoHaus.")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)

                    NavigationLink(destination: OnboardingView()) {
                        Text("Comenzar")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#2c6b3b"))
                            .padding(.horizontal, 36)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .cornerRadius(24)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .frame(maxWidth: .infinity)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }
        }
        .ignoresSafeArea()
    }
}

// Conversor HEX
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

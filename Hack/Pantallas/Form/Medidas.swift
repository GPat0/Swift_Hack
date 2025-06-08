import SwiftUI

struct Medidas: View {
    @State private var ancho: String = ""
    @State private var alto: String = ""
    @State private var paso: Int = 0  
    @State private var presupuesto: String = ""

    var anchoValor: CGFloat { CGFloat(Double(ancho) ?? 0) }
    var altoValor: CGFloat { CGFloat(Double(alto) ?? 0) }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 32) {
                HStack(spacing: 0) {
                    Spacer()
                    ForEach(0..<3) { idx in
                        VStack(spacing: 8) {
                            Image(systemName: icons[idx])
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(
                                    paso == idx ? .green :
                                    paso > idx ? Color.green.opacity(0.6) :
                                    Color.gray.opacity(0.4)
                                )
                                .frame(width: 48, height: 48)
                            Rectangle()
                                .frame(height: 3)
                                .foregroundColor(paso == idx ? .green : .clear)
                                .padding(.horizontal, 4)
                        }
                        if idx < 2 {
                            Spacer(minLength: 0)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 36)
                .padding(.top, 36)

                if paso == 0 {
                    Text("Ingresa las dimensiones\nde tu casa.")
                        .font(.system(size: 26, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    GeometryReader { geometry in
                        let maxAreaWidth = geometry.size.width - 40
                        let maxAreaHeight: CGFloat = 200

                        let width = max(anchoValor, 1)
                        let height = max(altoValor, 1)
                        let scale = min(maxAreaWidth / width, maxAreaHeight / height)

                        let rectWidth = width * scale
                        let rectHeight = height * scale

                        VStack {
                            Spacer()

                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        LinearGradient(colors: [.green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing),
                                        lineWidth: 2
                                    )
                                    .frame(width: rectWidth, height: rectHeight)

                                if altoValor > 0 {
                                    Text("\(altoValor, specifier: "%.1f") m")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                        .rotationEffect(.degrees(-90))
                                        .offset(x: rectWidth / 2 + 12)
                                }

                                if anchoValor > 0 {
                                    Text("\(anchoValor, specifier: "%.1f") m")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                        .offset(y: rectHeight / 2 + 12)
                                }
                            }

                            Spacer().frame(height: 60)

                            HStack(spacing: 40) {
                                inputField(label: "Alto", value: $alto)
                                inputField(label: "Ancho", value: $ancho)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(height: 280)
                } else if paso == 1 {
                    Text("Ingresa tu presupuesto:")
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)

                    TextField("$0.00", text: $presupuesto)
                        .keyboardType(.decimalPad)
                        .padding(18)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.07), radius: 8, x: 0, y: 4)
                        .padding(.horizontal, 12)

                    Spacer()
                } else if paso == 2 {
                    VStack(spacing: 32) {
                        Text("Generando modelo…")
                            .font(.system(size: 24, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .shadow(color: Color.black.opacity(0.13), radius: 3, x: 0, y: 1)
                            .padding(.top, 40)

                        Text("Espere mientras su modelo se genera")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)

                        EntityEffectView()
                            .frame(width: 180, height: 180)
                            .padding(.top, 12)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }

                Spacer()
            }
            .padding(.horizontal)

            if paso < 2 {
                Button(action: {
                    withAnimation {
                        paso += 1
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(colors: [.green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            if paso > 0 {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            paso -= 1
                        }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Regresar")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.green)
                    }
                }
            }
        }
    }

    private let icons = ["ruler", "banknote", "cube.box"]

    func inputField(label: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.black)

            HStack(spacing: 4) {
                TextField("0", text: value)
                    .keyboardType(.decimalPad)
                    .padding(10)
                    .frame(width: 70)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                LinearGradient(colors: [.green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing),
                                lineWidth: 1.5
                            )
                    )

                Text("m")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct EntityEffectView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            ForEach(0..<60, id: \.self) { i in
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.8),
                                Color.cyan.opacity(0.5)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2.4
                    )
                    .frame(width: CGFloat(i) * 3.0, height: CGFloat(i) * 3.0)
                    .opacity(isAnimating ? 0 : 1)
                    .scaleEffect(isAnimating ? 1.8 : 0.2)
                    .animation(
                        Animation.easeOut(duration: 2.2)
                            .repeatForever()
                            .delay(Double(i) * 0.04),
                        value: isAnimating
                    )
            }
        }
        .onAppear { isAnimating = true }
    }
}


#Preview {
    NavigationView {
        Medidas()
    }
}

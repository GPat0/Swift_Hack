import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    override init() {
        super.init()
        manager.delegate = self
    }
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
}

struct OnboardingView: View {
    @State private var currentPage: Int = 0
    @State private var showLocationRequest: Bool = false
    @State private var navigateToMap: Bool = false
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if showLocationRequest {
                CustomLocationPermissionView(
                    onAllow: {
                        locationManager.requestPermission()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                        navigateToMap = true
                                                    }
                    },
                    onDeny: {
                        showLocationRequest = false
                    }
                )
            } else if currentPage == 0 {
                Ubi_view(onNext: { withAnimation { currentPage = 1 } })
            } else if currentPage == 1 {
                Leaves_view(
                    onNext: { withAnimation { currentPage = 2 } },
                    onBack: { withAnimation { currentPage = 0 } }
                )
            } else if currentPage == 2 {
                Project_view(
                    onStart: {
                        withAnimation { showLocationRequest = true }
                    },
                    onSkip: {},
                    onBack: { withAnimation { currentPage = 1 } }
                )
            }
            NavigationLink(destination: Mapa(), isActive: $navigateToMap) {
                                EmptyView()
                            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}

// Pantalla personalizada de permisos de ubicación
struct CustomLocationPermissionView: View {
    var onAllow: () -> Void
    var onDeny: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 20) {
                // Imagen de mapa personalizada o SF Symbol
                RoundedRectangle(cornerRadius: 18)
                    .fill(LinearGradient(colors: [Color.green.opacity(0.2), Color.blue.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 240, height: 100)
                    .overlay(
                        // Usa tu imagen personalizada si existe, si no usa SF Symbol
                        Group {
                            if let image = UIImage(named: "mapaubi") {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            } else {
                                // SF Symbol alternativo más parecido a un mapa real
                                ZStack {
                                    Image(systemName: "map")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.green.opacity(0.8))
                                    
                                    // Pin de ubicación encima del mapa
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                        .offset(y: -10)
                                }
                            }
                        }
                    )
                    .padding(.top, 30)
                
                VStack(spacing: 12) {
                    Text("¿Permitir que la app use tu ubicación?")
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Text("Necesitamos tu ubicación para mostrarte información relevante y mejorar tu experiencia en la app.")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .lineSpacing(2)
                }
                .padding(.bottom, 16)
            }
            .background(Color.white)
            .cornerRadius(22)
            .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 6)
            .padding(.horizontal, 28)

            VStack(spacing: 0) {
                Button(action: onAllow) {
                    Text("Permitir al usarse la app")
                        .foregroundColor(.blue)
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .background(Color.white)
                
                Divider()
                    .background(Color.gray.opacity(0.3))
                
                Button(action: onDeny) {
                    Text("No permitir")
                        .foregroundColor(.red)
                        .font(.system(size: 17, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .background(Color.white)
            }
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 6)
            .padding(.horizontal, 28)
            .padding(.top, 12)
            .padding(.bottom, 50)
            
            Spacer()
        }
        .background(Color.black.opacity(0.25).ignoresSafeArea())
    }
}

// Pantalla 1: Muchas casitas
struct Ubi_view: View {
    var onNext: () -> Void

    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: -16) {
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 54, height: 54)
                    .foregroundColor(.green.opacity(0.8))
                    .shadow(radius: 2, y: 2)
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 54, height: 54)
                    .foregroundColor(.green.opacity(0.5))
                    .offset(y: 10)
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 54, height: 54)
                    .foregroundColor(.green.opacity(0.3))
                    .offset(y: 16)
            }
            .padding(.bottom, 18)

            Text("Crea tu hogar.")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 6)

            Text("Genera tu propio modelo 3D de tu hogar diseñado para las necesidades de tu zona")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 36)
                .padding(.bottom, 32)

            Button(action: { onNext() }) {
                Image(systemName: "arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 54, height: 54)
                    .background(
                        LinearGradient(
                            colors: [Color.green, Color.mint],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
                    .shadow(color: Color.green.opacity(0.15), radius: 6, x: 0, y: 2)
            }
            .padding(.top, 16)

            Spacer()

            HStack(spacing: 10) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: 10, height: 10)
            }
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Pantalla 2: Muchas hojas
struct Leaves_view: View {
    var onNext: () -> Void
    var onBack: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Spacer()
                // Icono de muchas hojas
                HStack(spacing: -16) {
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .frame(width: 54, height: 54)
                        .foregroundColor(.green.opacity(0.8))
                        .shadow(radius: 2, y: 2)
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .frame(width: 54, height: 54)
                        .foregroundColor(.green.opacity(0.5))
                        .offset(y: 10)
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .frame(width: 54, height: 54)
                        .foregroundColor(.green.opacity(0.3))
                        .offset(y: 16)
                }
                .padding(.bottom, 18)

                Text("Diseño que te\nprotege.")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 6)

                Text("Reduce tus probabilidades de ser\nafectado por efectos climatológicos.")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 36)
                    .padding(.bottom, 32)

                Button(action: { onNext() }) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 54, height: 54)
                        .background(
                            LinearGradient(
                                colors: [Color.green, Color.mint],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(Circle())
                        .shadow(color: Color.green.opacity(0.15), radius: 6, x: 0, y: 2)
                }
                .padding(.top, 16)

                Spacer()

                HStack(spacing: 10) {
                    Circle()
                        .fill(Color.green.opacity(0.3))
                        .frame(width: 10, height: 10)
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                    Circle()
                        .fill(Color.green.opacity(0.3))
                        .frame(width: 10, height: 10)
                }
                .padding(.bottom, 32)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // Flecha de regresar en la esquina superior izquierda
            Button(action: { onBack() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.green)
                    .padding(.leading, 20)
                    .padding(.top, 30)
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}


// Pantalla 3: Casco o persona
struct Project_view: View {
    var onStart: () -> Void
    var onSkip: () -> Void
    var onBack: () -> Void

    var body: some View {
        VStack {
            // Botón de regresar arriba a la izquierda
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.green)
                        .padding()
                }
                Spacer()
            }
            .padding(.top, 12)
            .padding(.leading, 6)

            Spacer()
            
            // Icono de casco centrado, con fondo circular gris claro
            ZStack {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 120, height: 120)
                Image(systemName: "helm") // Casco de trabajador, disponible en iOS 16+
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
            }
            .padding(.bottom, 28)
            
            // Título grande
            Text("Crea tu primer\nproyecto")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.bottom, 28)
            
            // Botón "Empezar"
            Button(action: onStart) {
                Text("Empezar")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            colors: [Color.green, Color.mint],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(26)
            }
            .padding(.horizontal, 38)
            .padding(.bottom, 12)
            
            // Botón "Omitir"
            Button(action: onSkip) {
                Text("Omitir")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.green)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 26)
                            .stroke(LinearGradient(
                                colors: [Color.green, Color.mint],
                                startPoint: .leading,
                                endPoint: .trailing
                            ), lineWidth: 1.2)
                    )
            }
            .padding(.horizontal, 38)
            .padding(.bottom, 8)
            
            Spacer()
            
            // Puntos de página
            HStack(spacing: 10) {
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
            }
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
    }
}

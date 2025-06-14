import SwiftUI
import MapKit

struct Mapa: View {
    private let coloniaGuadalupe = Colonia(
        id: "1",
        nombre_colonia: "Guadalupe",
        temperatura: 29.5,
        coordenada: CLLocationCoordinate2D(latitude: 25.6761, longitude: -100.2561)
    )
    
    var navigateToMedidas: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var showMedidas: Bool = false
    @State private var colonias: [Colonia] = []
    @State private var selectedColonia: Colonia? = nil
    @State private var searchText: String = ""
    
    init() {
        _colonias = State(initialValue: [coloniaGuadalupe])
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                MapView(selectedColonia: $selectedColonia)
                    .edgesIgnoringSafeArea(.all)
                
                ZStack(alignment: .topLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        ZStack {
                            VisualEffectBlur(blurStyle: .systemThinMaterialDark)
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                            
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "arrow.left")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(Color.green.opacity(0.85))
                        }
                    }
                    .padding(.top, 30)
                    .padding(.leading, 16)
                    
                    
                    // 🔍 Search bar centrada
                    ZStack {
                        VisualEffectBlur(blurStyle: .systemThinMaterialDark)
                            .clipShape(Capsule())
                            .frame(height: 50)
                        
                        Capsule()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 50)
                        
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding(.leading, 12)
                            
                            ZStack(alignment: .leading) {
                                if searchText.isEmpty {
                                    Text("Ingresa una colonia…")
                                        .foregroundColor(.white.opacity(0.6))
                                        .padding(.vertical, 10)
                                        .padding(.leading, 5)
                                }
                                
                                TextField("", text: $searchText)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.leading, 5)
                            }
                            .padding(.trailing, 12)
                        }
                        .padding(.leading, 8)
                    }
                    .padding(.horizontal, 80)
                    .padding(.top, 30)
                }
                
                if !searchText.isEmpty {
                    if !searchText.isEmpty {
                        VStack {
                            Spacer().frame(height: 90)
                            
                            VStack(spacing: 8) {
                                let coincidencias = colonias
                                    .filter { $0.nombre_colonia
                                        .lowercased().contains(searchText.lowercased()) }
                                    .sorted { a, b in
                                        a.nombre_colonia.lowercased().hasPrefix(searchText.lowercased()) &&
                                        !b.nombre_colonia.lowercased().hasPrefix(searchText.lowercased())
                                    }
                                    .prefix(5)
                                
                                ForEach(coincidencias, id: \.id) { colonia in
                                    Button(action: {
                                        selectedColonia = colonia
                                        searchText = ""
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }) {
                                        ZStack {
                                            VisualEffectBlur(blurStyle: .systemThinMaterialDark)
                                                .clipShape(Capsule())
                                                .frame(height: 40)
                                            
                                            Capsule()
                                                .fill(Color.white.opacity(0.08))
                                                .frame(height: 40)
                                            
                                            Text(colonia.nombre_colonia)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 20)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 70)
                        }
                    }
                    
                }
                
                // 📍 Panel de información de la colonia
                if let colonia = selectedColonia {
                    VStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Colonia \(colonia.nombre_colonia) – MTY, Nuevo León")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            
                            HStack(alignment: .top, spacing: 16) {
                                Image("Guadalupe")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipped()
                                    .cornerRadius(16)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("☀️ Verano: 34 °C a 40 °C durante el día")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                    Text("❄️ Invierno: 8 °C a 22 °C")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                    Text("🔥 En días extremos puede superar los 42 °C")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                    Text("⚠️ Muy caluroso, con riesgo de golpes de calor.")
                                        .font(.footnote)
                                        .foregroundColor(.white.opacity(0.9))
                                }
                            }
                            
                            Button(action: {
                                showMedidas = true
                            }) {
                                Text("Seleccionar")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.0, green: 0.79, blue: 0.42),
                                                Color(red: 0.02, green: 0.85, blue: 0.95)
                                            ]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                            }
                        }
                        .padding()
                        .background(
                            VisualEffectBlur(blurStyle: .systemThinMaterialDark)
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        )
                        .padding()
                    }
                }
                NavigationLink(destination: Medidas(), isActive: $showMedidas) {
                                    EmptyView()
                                }
            }
        }
    }
}

#Preview {
    Mapa()
}


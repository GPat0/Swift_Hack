import SwiftUI
import RealityKit

struct Resultados: View {
    @State private var selectedButton: Int? = 1
    @State private var showFase1 = false
    @State private var showFase2 = false
    @State private var showFase3 = false
    @State private var modelRotation: Float = 0
    @State private var lastRotation: Float = 0
    @State private var modelScale: Float = 0.07
    @State private var lastScale: Float = 1.0

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Eco Hogar")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    Text("Colonia Guadalupe – Monterrey, Nuevo León")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .padding(.top, 10)
                .padding(.horizontal, 24)

                if #available(iOS 18.0, *) {
                    RealityView { content in
                        if let model = try? await ModelEntity(named: "eco_house_2") {
                            let bounds = model.visualBounds(relativeTo: nil)
                            let size = bounds.extents
                            let targetSize: Float = 2
                            let maxDimension = max(size.x, size.y, size.z)
                            let scale = targetSize / maxDimension
                            model.setScale([scale, scale, scale], relativeTo: nil)
                            model.position = [
                                -bounds.center.x * scale,
                                -bounds.center.y * scale,
                                -bounds.center.z * scale
                            ]
                            model.components.set(InputTargetComponent())
                            model.generateCollisionShapes(recursive: true)

                            let anchor = AnchorEntity(world: .zero)
                            anchor.addChild(model)
                            content.add(anchor)
                        }
                    } update: { content in
                        if let anchor = content.entities.first as? AnchorEntity,
                           let model = anchor.children.first {
                            model.transform.rotation = simd_quatf(angle: modelRotation, axis: [0,1,0])
                            model.transform.scale = [modelScale, modelScale, modelScale]
                        }
                    }
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .background(Color.white)
                    .padding(.horizontal, 24)
                    .gesture(
                        SimultaneousGesture(
                            DragGesture()
                                .onChanged { value in
                                    let delta = Float(value.translation.width) * 0.01
                                    modelRotation = lastRotation + delta
                                }
                                .onEnded { _ in
                                    lastRotation = modelRotation
                                },
                            MagnificationGesture()
                                .onChanged { value in
                                    let newScale = lastScale * Float(value)
                                    modelScale = min(max(newScale, 0.5), 2.5)
                                }
                                .onEnded { _ in
                                    lastScale = modelScale
                                }
                        )
                    )
                }

                Spacer().frame(height: 16)

                HStack(spacing: 16) {
                    ForEach(1...3, id: \.self) { idx in
                        selectorButton(
                            idx: idx,
                            selected: selectedButton == idx,
                            action: { selectedButton = idx }
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity)

                ScrollView(showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 0) {
                        if let selected = selectedButton {
                            if selected == 1 {
                                Text("Información de la zona")
                                    .font(.headline)
                                    .padding(.bottom, 2)
                                Text("""
Clima:
- Verano: 34 °C a 40 °C durante el día
- Invierno: 8 °C a 22 °C
- En días extremos puede superar los 42 °C
- Muy caluroso, con riesgo de golpes de calor

El clima es semíarido cálido, con veranos muy calurosos, sequía notable entre julio y agosto, y lluvias concentradas entre mayo y septiembre.
""")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 16)
                                
                                Text("Características de la casa")
                                    .font(.headline)
                                    .padding(.bottom, 8)
                                VStack(spacing: 8) {
                                    DisclosureGroup(
                                        isExpanded: $showFase1,
                                        content: {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text("""
Bloques de adobe: El adobe es un material natural con alta inercia térmica y excelente aislamiento. Esto permite que la casa se mantenga fresca en los veranos calurosos y conserve el calor en invierno, reduciendo la necesidad de climatización artificial. Además, el adobe regula la humedad interior y es resistente a la degradación por el clima seco.
""")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.black)
                                            }
                                            .padding(.vertical, 4)
                                        },
                                        label: {
                                            HStack {
                                                Image(systemName: "square.grid.2x2")
                                                    .foregroundColor(.green)
                                                Text("Estructura y paredes de adobe")
                                                    .font(.system(size: 16, weight: .semibold))
                                            }
                                        }
                                    )
                                    .accentColor(.black)
                                    .padding(.vertical, 4)
                                    DisclosureGroup(
                                        isExpanded: $showFase2,
                                        content: {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text("""
                                                Teja de barro: La teja de barro, protege eficazmente contra lluvias intensas y frecuentes en la región. Su diseño inclinado facilita el escurrimiento del agua, reduciendo el riesgo de filtraciones. Además, la teja de barro es un excelente aislante térmico natural: ayuda a mantener la vivienda fresca durante olas de calor extremo y conserva el calor en invierno, adaptándose a temperaturas que pueden superar los 42 °C en verano y descender a 8 °C en invierno. La estructura de madera sostenible aporta resistencia y es de bajo impacto ambiental.
                                                """)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.black)
                                            }
                                            .padding(.vertical, 4)
                                        },
                                        label: {
                                            HStack {
                                                Image(systemName: "house.fill")
                                                    .foregroundColor(.green)
                                                Text("Techo de tejas de barro")
                                                    .font(.system(size: 16, weight: .semibold))
                                            }
                                        }
                                    )
                                    .accentColor(.black)
                                    .padding(.vertical, 4)
                                    DisclosureGroup(
                                        isExpanded: $showFase3,
                                        content: {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text("""
Tubos de terracota: Aprovechan la evaporación y la inercia térmica de la arcilla para reducir la temperatura interior hasta 10-15 °C respecto al exterior, sin consumo eléctrico. Esto es clave para enfrentar el calor extremo de la zona y prevenir golpes de calor. Además, la terracota es un material natural y reciclable.
""")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.black)
                                            }
                                            .padding(.vertical, 4)
                                        },
                                        label: {
                                            HStack {
                                                Image(systemName: "wind.snow")
                                                    .foregroundColor(.green)
                                                Text("Enfriamiento por tubos de terracota")
                                                    .font(.system(size: 16, weight: .semibold))
                                            }
                                        }
                                    )
                                    .accentColor(.black)
                                    .padding(.vertical, 4)
                                }
                                .background(Color.white)
                            } else if selected == 2 {
                                Text("Planos de la casa").font(.headline)
                                Text("Planos generados para ver la distribucion de tu futuro hogar.")
                                Image("Plano")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                            } else if selected == 3 {
                                Text("Lista de Materiales").font(.headline)
                                Text("Con un presupuesto de 100,000 pesos, esto es una lista de materiales para empezar a construir tu hogar.")
                                    .padding(.bottom, 8)
                                
                                DisclosureGroup("1️⃣ Estructura y Paredes", isExpanded: $showFase1) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        tableFase1()
                                        Text("Subtotal Fase 1: $56,760 MXN")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .padding(.top, 4)
                                    }
                                    .padding(.vertical, 4)
                                }
                                .accentColor(.black)
                                .fontWeight(.bold)
                                .padding(.vertical, 4)
                                
                                DisclosureGroup("2️⃣ Techo de Lámina con Aislante", isExpanded: $showFase2) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        tableFase2()
                                        Text("Subtotal Fase 2: $41,800 MXN")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .padding(.top, 4)
                                    }
                                    .padding(.vertical, 4)
                                }
                                .accentColor(.black)
                                .fontWeight(.bold)
                                .padding(.vertical, 4)
                                
                                DisclosureGroup("3️⃣ Enfriamiento por Tubos de Arcilla", isExpanded: $showFase3) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        tableFase3()
                                        Text("Subtotal Fase 3: $4,100 MXN")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .padding(.top, 4)
                                    }
                                    .padding(.vertical, 4)
                                }
                                .accentColor(.black)
                                .fontWeight(.bold)
                                .padding(.vertical, 4)
                                
                                Text("Total General: $102,660 MXN")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                                    .padding(.top, 10)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .safeAreaInset(edge: .bottom) {
                Navbar()
                    .padding(.horizontal, 20)
                    .background(Color.white)
            }
        }
    }
}

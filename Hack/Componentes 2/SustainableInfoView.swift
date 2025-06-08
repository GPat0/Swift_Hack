import SwiftUI

struct sustainableInfoView: View {
    var body: some View {
        ZStack {
            // Fondo elegante y sutil
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    // Header con ícono y título
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.green.opacity(0.18))
                                .frame(width: 60, height: 60)
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                                .foregroundColor(.green)
                                .shadow(color: .green.opacity(0.2), radius: 6, x: 0, y: 2)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Apoyos para Vivienda Ecológica")
                                .font(.title)
                                .fontWeight(.semibold)
                            Text("Programas y beneficios oficiales en México")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 4)
                    
                    // Tarjetas de beneficios
                    VStack(spacing: 22) {
                        BenefitCardApple(
                            icon: "house.lodge.fill",
                            iconColor: .brown,
                            title: "Mejoramiento Integral Sustentable",
                            description: "Subsidio de hasta 40% para ecotecnologías y eficiencia energética en vivienda social, incluyendo sistemas pasivos como tubos de terracota, aislamiento natural y adobe.",
                            linkTitle: "Solicitar subsidio",
                            url: "https://www.fide.org.mx/?page_id=14841"
                        )
                        BenefitCardApple(
                            icon: "building.columns.fill",
                            iconColor: .blue,
                            title: "EcoCasa (SHF)",
                            description: "Créditos preferenciales para casas que reduzcan emisiones usando materiales ecológicos y técnicas pasivas. Ideal para autoconstrucción y vivienda social.",
                            linkTitle: "Más sobre EcoCasa",
                            url: "https://www.gob.mx/shf/documentos/ecocasa-programa-de-cooperacion-financiera?state=published"
                        )
                        BenefitCardApple(
                            icon: "creditcard.fill",
                            iconColor: .purple,
                            title: "Hipoteca Verde (INFONAVIT/FOVISSSTE)",
                            description: "Crédito adicional para mejoras ecológicas: aislamiento, sistemas de ahorro y tecnologías pasivas.",
                            linkTitle: "Conoce Hipoteca Verde",
                            url: "https://portalmx.infonavit.org.mx/wps/portal/infonavit.web/proveedores-externos/para-tu-gestion/desarrolladores/hipoteca-verde/!ut/p/z1/pZJbC4JAEIV_ja_OqLlYb2uYF6QLKNm-hMW2GuqGWf79xJ6CUqF5m-E7M4fDAIMEWJU-c5E2uazSousPjByJi-gtZ9raDVDH3caOtrFuBzPPhP0AYBBCgP2h30YT9bqF6NrYAZZnIV05vjMPDd2NtWl6_FEU__HfA2x4_R7YwAmDOGQEICNAn2EPDIU0ZjMAJgp5en8ErU6GJYDV_MJrXquPuhtnTXO7LxRUsG1bVUgpCq6eZangN0km7w0knyTcyrirBHP_ahbPkL4AaWPiCw!!/dz/d5/L2dBISEvZ0FBIS9nQSEh/"
                        )
                        BenefitCardApple(
                            icon: "drop.triangle.fill",
                            iconColor: .cyan,
                            title: "NAMA Vivienda Sustentable (CONAVI)",
                            description: "Subsidios y créditos blandos para eficiencia energética y sistemas pasivos como tubos de terracota y aislamiento natural.",
                            linkTitle: "Detalles NAMA Vivienda",
                            url: "https://www.gob.mx/conavi/documentos/nama-mexicana-de-vivienda-sustentable-28728"
                        )
                        BenefitCardApple(
                            icon: "book.fill",
                            iconColor: .orange,
                            title: "Guía de Programas de Fomento (SEMARNAT)",
                            description: "Guía oficial con todos los apoyos federales, privados e internacionales para vivienda ecológica y social.",
                            linkTitle: "Conoce Programas",
                            url: "https://www.gob.mx/semarnat/documentos/guia-de-programas-de-fomento-a-la-generacion-de-energia-con-recursos-renovables"
                        )
                        BenefitCardApple(
                            icon: "bolt.circle.fill",
                            iconColor: .yellow,
                            title: "Modelos ESCO y financiamiento",
                            description: "Empresas instalan tecnologías eficientes y tú pagas con los ahorros energéticos. Útil para sistemas de enfriamiento e iluminación eficiente.",
                            linkTitle: "Ver modelos ESCO",
                            url: "https://www.evolusol.cl/modelo-de-financiamiento-esco/"
                        )
                    }
                    
                    // Proceso de acceso
                    GroupBox(label: Label("¿Cómo acceder a estos apoyos?", systemImage: "arrow.right.circle.fill").foregroundColor(.green)) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("1. Identifica el programa ideal y revisa requisitos en el enlace.")
                            Text("2. Prepara documentación de tu vivienda (planos, materiales, tecnologías pasivas).")
                            Text("3. Solicita el apoyo o crédito en la plataforma oficial o presencialmente.")
                            Text("4. Presenta evidencia del ahorro energético o impacto ambiental positivo.")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                    }
                    .groupBoxStyle(DefaultGroupBoxStyle())
                    .padding(.top, 4)
                    
                    // Beneficios
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Beneficios de una vivienda ecológica")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 6) {
                            Label("Ahorro en energía y agua", systemImage: "drop.fill")
                            Label("Confort térmico superior", systemImage: "thermometer.sun.fill")
                            Label("Acceso a subsidios y créditos", systemImage: "creditcard.fill")
                            Label("Contribución a la sostenibilidad", systemImage: "leaf.fill")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(color: .green.opacity(0.04), radius: 2, x: 0, y: 1)
                    .padding(.bottom, 60)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct BenefitCardApple: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    let linkTitle: String
    let url: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(iconColor.opacity(0.12))
                        .frame(width: 48, height: 48)
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(iconColor)
                }
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            Link(destination: URL(string: url)!) {
                Text(linkTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(iconColor)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 14)
                    .background(iconColor.opacity(0.10))
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: iconColor.opacity(0.04), radius: 5, x: 0, y: 2)
        )
    }
}

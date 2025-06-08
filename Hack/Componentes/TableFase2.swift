import SwiftUI

struct tableFase2: View {
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.fixed(90), alignment: .trailing),
        GridItem(.fixed(100), alignment: .trailing)
    ]
    let rows = [
        ["Lámina galvanizada", "40 piezas", "$12,000"],
        ["Estructura soporte", "48 m", "$5,760"],
        ["Viruta", "10 bolsas", "$500"],
        ["Cal", "5 sacos", "$350"],
        ["Tierra", "10 carretillas", "$0"],
        ["Tornillos", "320", "$320"],
        ["Arandelas/cinta selladora", "-", "$950"]
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            LazyVGrid(columns: columns, spacing: 6) {
                Text("Material").fontWeight(.bold)
                Text("Cantidad").fontWeight(.bold)
                Text("Precio").fontWeight(.bold)
            }
            Divider()
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(rows, id: \.self) { row in
                    Text(row[0])
                    Text(row[1])
                    Text(row[2])
                }
            }
        }
        .font(.system(size: 14))
        .padding(.vertical, 2)
    }
}

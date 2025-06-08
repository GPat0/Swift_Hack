import SwiftUI

struct tableFase2: View {
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.fixed(90), alignment: .trailing),
        GridItem(.fixed(100), alignment: .trailing)
    ]
    let rows = [
        ["Teja de barro económica", "1,300 piezas", "$23,400"],
        ["Madera ecológica (viga/polín)", "70 m", "$8,400"],
        ["Listón/madera secundaria", "200 m", "$7,000"],
        ["Clavos/tornillos", "20 kg", "$1,000"],
        ["Cinta selladora", "5 rollos", "$1,000"],
        ["Aislante natural", "20 bolsas", "$1,000"]
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

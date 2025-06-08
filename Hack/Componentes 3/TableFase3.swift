import SwiftUI

struct tableFase3: View {
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.fixed(90), alignment: .trailing),
        GridItem(.fixed(100), alignment: .trailing)
    ]
    let rows = [
        ["Tubos de terracota", "25", "$3,750"],
        ["Mortero de cal", "5 sacos", "$350"]
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

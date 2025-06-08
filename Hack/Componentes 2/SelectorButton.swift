import SwiftUI

struct selectorButton: View {
    let idx: Int
    let selected: Bool
    let action: () -> Void

    var symbolName: String {
        switch idx {
        case 1: return "info.circle"
        case 2: return "compass.drawing"
        default: return "list.bullet"
        }
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundColor(selected ? .white : Color.green)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .background {
            if selected {
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.9), Color.green.opacity(0.7)]),
                    startPoint: .leading, endPoint: .trailing
                )
            } else {
                Color.white
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.green, lineWidth: selected ? 0 : 2)
        )
    }
}

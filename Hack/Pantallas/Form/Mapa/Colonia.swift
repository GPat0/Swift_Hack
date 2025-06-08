import Foundation
import CoreLocation

struct Colonia: Identifiable, Hashable {
    let id: String
    let nombre_colonia: String
    let temperatura: Double
    let coordenada: CLLocationCoordinate2D

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Colonia, rhs: Colonia) -> Bool {
        lhs.id == rhs.id
    }
}

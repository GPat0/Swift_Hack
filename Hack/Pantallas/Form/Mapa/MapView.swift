import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var selectedColonia: Colonia?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.mapType = .mutedStandard
        
        if let window = UIApplication.shared.windows.first {
                window.overrideUserInterfaceStyle = .dark
            }

        let center = CLLocationCoordinate2D(latitude: 25.6866, longitude: -100.3161)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        mapView.setRegion(.init(center: center, span: span), animated: false)

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        context.coordinator.selectedColoniaNombre = selectedColonia?.nombre_colonia

        mapView.removeAnnotations(mapView.annotations)

        if let colonia = selectedColonia {
            let region = MKCoordinateRegion(
                center: colonia.coordenada,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            mapView.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = colonia.coordenada
            annotation.title = colonia.nombre_colonia
            annotation.subtitle = "\(String(format: "%.1f", colonia.temperatura)) °C"
            mapView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var selectedColoniaNombre: String?
    }
}

//
//  MapView.swift
//  Scoota
//
//  Created by Dums, Fabiola on 06.02.23.
//
import MapKit
import SwiftUI

// https://stackoverflow.com/questions/56940371/swiftui-how-to-use-mkoverlayrenderer
struct MapView: UIViewRepresentable {    
    @Binding var centerCoor: CLLocationCoordinate2D
    
    var span: MKCoordinateSpan =  MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    
    func makeUIView(context: Context) -> some MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        let trackingButton = MKUserTrackingButton(mapView: mapView)
        
        mapView.addSubview(trackingButton)
        mapView.delegate = context.coordinator
        mapView.isScrollEnabled = true
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(NoparkAnnotation.self))
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(SlowAnnotation.self))
        
        addPolygons(mapView: mapView)
        mapView.setRegion(MKCoordinateRegion(center: centerCoor, span: span), animated: true)
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygon = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygon)
                let zoneColor =  Color(CurrentOverlay.shared.polygonInfo.zoneType.getZone().zoneColor)
                renderer.fillColor = UIColor(zoneColor.opacity(0.5))
                renderer.strokeColor = UIColor(zoneColor)
                renderer.lineWidth = 1
                
                return renderer
            }
            return MKOverlayRenderer()
        }
    
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            let currentSpan = mapView.region.span
            parent.span = currentSpan
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            guard !annotation.isKind(of: MKUserLocation.self) else {
                // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
                return nil
            }
            
            var annotationView: MKAnnotationView?
            
            if let annotation = annotation as? NoparkAnnotation {
                annotationView = setupNoparkAnnotationView(for: annotation, on: mapView)
            } else if let annotation = annotation as? SlowAnnotation {
                annotationView = setupSlowAnnotationView(for: annotation, on: mapView)
            }
            
            return annotationView
        }

        
        private func setupNoparkAnnotationView(for annotation: NoparkAnnotation, on mapView: MKMapView) -> MKAnnotationView {
            return setupAnnotationView(for: annotation, on: mapView, zoneType: ZoneType.nopark, identifierClass: NoparkAnnotation.self)
        }
        private func setupSlowAnnotationView(for annotation: SlowAnnotation, on mapView: MKMapView) -> MKAnnotationView {
            return setupAnnotationView(for: annotation, on: mapView, zoneType: ZoneType.slow, identifierClass: SlowAnnotation.self)
        }
        private func setupAnnotationView(for annotation: MKAnnotation, on mapView: MKMapView, zoneType: ZoneType, identifierClass: AnyClass) -> MKAnnotationView {
            let zone = zoneType.getZone()
            let reuseIdentifier = NSStringFromClass(identifierClass)
            let flagAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)
            flagAnnotationView.canShowCallout = true
            // Provide the annotation view's image.
            let image = UIImage(systemName: zone.zoneIcon) ?? UIImage(named:zone.zoneIcon)!
            flagAnnotationView.image = image
            // Provide the left image icon for the annotation.
            flagAnnotationView.leftCalloutAccessoryView = UIImageView(image: image)
            flagAnnotationView.leftCalloutAccessoryView?.tintColor = UIColor(Color.black)
            flagAnnotationView.leftCalloutAccessoryView?.backgroundColor = UIColor(Color(zone.zoneColor))
            return flagAnnotationView
        }
    }
    
}
private extension MapView {
    func addPolygons(mapView: MKMapView) {
        let overlayList: [CustomOverlay] = CustomOverlays.shared.returnOverlayList()
        for item in overlayList {
            CurrentOverlay.shared.changePolygon(newPolygon: item.polygonInfo)
            if (item.polygonInfo.zoneType == .nopark) {
                let annotation = NoparkAnnotation()
                annotation.coordinate = item.overlay.coordinate
                mapView.addAnnotation(annotation)
            } else if (item.polygonInfo.zoneType == .slow) {
                let annotation = SlowAnnotation()
                annotation.coordinate = item.overlay.coordinate
                mapView.addAnnotation(annotation)
            }
            mapView.addOverlay(item.overlay)
            mapView.setVisibleMapRect(item.overlay.boundingMapRect, animated: true)
        }
    }
}

class NoparkAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 37.779_379, longitude: -122.418_433)
    var title: String? = ZoneType.nopark.getZone().zoneTitle
    var subtitle: String? = ZoneType.nopark.getZone().zoneDescription
}

class SlowAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 37.779_379, longitude: -122.418_433)
    var title: String? = ZoneType.slow.getZone().zoneTitle
    var subtitle: String? = ZoneType.slow.getZone().zoneDescription
}

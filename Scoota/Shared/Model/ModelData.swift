//
//  ModelData.swift
//  Scoota
//
//  Created by Dums, Fabiola on 27.01.23.
//

import MapKit
import Foundation
import SwiftUI
import CoreGraphics
import Combine

final class ModelData: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    private var timer: Cancellable?
    
    
    @Published private(set) var isRunning = false {
        didSet{
            if self.isRunning {
                self.start()
            } else {
                self.stop()
            }
        }
    }
    @Published private(set) var elapsedTime: TimeInterval = 0
    @Published private(set) var rentalPeriodInSeconds: TimeInterval = 0
    
    private func start() -> Void {
        self.startTime = Date()
        self.timer?.cancel()
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.elapsedTime = self.getElapsedTime()
            }
    }
    
    private func stop() -> Void {
        self.timer?.cancel()
        self.timer = nil
        self.rentalPeriodInSeconds = self.getElapsedTime()
        self.startTime = nil
    }
    
    func reset() -> Void {
        self.accumulatedTime = 0
        self.elapsedTime = 0
        self.startTime = nil
        self.isRunning = false
    }
    
    
    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)
    }
    
    func startRide () {
        self.isRunning = true
    }
    
    func stopRide() {
        self.isRunning = false
    }
    
    
    @Published var distanceTravelled = 0.0
    
    @Published var scooterId = ""
    @Published var centerCoordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12)
    
    @Published var activeZone: Zone = ZoneType.normal.getZone()

    @Published var showMapSheet: Bool = false
    
    private var locationManager: CLLocationManager?
    
    private func checkIfLocationServiceIsEnabled() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.startUpdatingLocation()
        locationManager!.distanceFilter = 1
        locationManager!.activityType = .fitness
        locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func setup(){
        createPolygons()
        checkIfLocationServiceIsEnabled()
        checkIfLocationServiceIsEnabled()
    }

    //    since this implementation is only a prototypical development of the App Clip only the happy path is implemented, therefore we assume the user gives location permission
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let locationManager = self.locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("ALERT -> location is restricted")
        case .denied:
            print("ALERT -> location is denied")
        case .authorizedAlways, .authorizedWhenInUse:
            checkInitial()
        @unknown default:
            break
        }
    }
      
    private func checkInitial() {
        guard let coordinates = locationManager?.location?.coordinate else { return }
        checkZones(coordinates: coordinates)
    }
    
    func checkZones(coordinates: CLLocationCoordinate2D) {
        var hasEnteredZone: Bool = false
        for item in CustomOverlays.shared.returnOverlayList(){
            let polygon = item.polygon
            if (polygon.containsCoordinates(coordinates: coordinates)){
                hasEnteredZone = true
                self.activeZone =  item.polygonInfo.zoneType.getZone()
                break
            }
        }
        if (!hasEnteredZone){
            self.activeZone = ZoneType.normal.getZone()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        checkZones(coordinates: location.coordinate)
        centerCoordinate = location.coordinate
        distanceTravelled += 0.01
    }
    
    // create map overlay as custom type to store all overlays and polygons
    private func createOverlay(overlay: MKOverlay, info: PolygonInfo, polygon: MKPolygon) {
        let newMapOverlay = CustomOverlay(overlay: overlay, polygonInfo: info, polygon: polygon)
        CustomOverlays.shared.addOverlay(mapOverlayer: newMapOverlay)
    }
    
    
    private func createPolygons() {
        // load polygons from GeoJSON
        let geoJson: [MKGeoJSONObject] = loadGeoJson("zones")
        
        // transform each polygon into MKPolygon
        for item in geoJson {
            if let feature = item as? MKGeoJSONFeature {
                let geometry = feature.geometry.first
                let propData = feature.properties!
                
                if let polygon = geometry as? MKPolygon {
                    guard  let polygonInfo = try? JSONDecoder.init().decode(PolygonInfo.self, from: propData) else { return }
                    
                    self.createOverlay(overlay: polygon, info: polygonInfo, polygon: polygon)
                }
            }
        }
    }
}

// Source: https://github.com/zpg6/SwiftUIPolygonGeofence
extension MKPolygon {
    func containsCoordinates(coordinates: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint: MKMapPoint = MKMapPoint(coordinates)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        if polygonRenderer.path == nil {
            return false
        }else{
            return polygonRenderer.path.contains(polygonViewPoint)
        }
    }
}

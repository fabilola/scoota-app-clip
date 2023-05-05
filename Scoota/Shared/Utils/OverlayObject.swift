//
//  OverlayObject.swift
//  Scoota
//
//  Created by Dums, Fabiola on 08.02.23.
//
import MapKit
import Foundation


struct CustomOverlay {
    var overlay : MKOverlay
    var polygonInfo : PolygonInfo
    var polygon: MKPolygon
}

//Storing our Overlay Shape
class CustomOverlays {
    private var overlayList = [CustomOverlay]()
    static var shared = CustomOverlays()
    
    func addOverlay(mapOverlayer: CustomOverlay) {
        CustomOverlays.shared.overlayList.append(mapOverlayer)
    }
    
    func returnOverlayList() -> [CustomOverlay] {
        return CustomOverlays.shared.overlayList
    }
}

//Track the latest Shape Overlay
class CurrentOverlay {
    static let shared = CurrentOverlay(polygonInfo: PolygonInfo(zoneType: ZoneType.normal))
    var polygonInfo : PolygonInfo
    
    init(polygonInfo: PolygonInfo){
        self.polygonInfo = polygonInfo
    }
    
    func changePolygon(newPolygon: PolygonInfo){
        self.polygonInfo = newPolygon
    }
}



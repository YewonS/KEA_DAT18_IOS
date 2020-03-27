//
//  FirebaseRepo.swift
//  MapDemo2020
//
//  Created by Yewon Seo on 2020/03/20.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class FirebaseRepo {
    
    private static let db = Firestore.firestore() // get the Firebase instance
    private static let path = "map"
    
    static func startListener(vc: ViewController) {
        print("listener started")
        // vc.updateMarkers()
        db.collection(path).addSnapshotListener{ (snap, error) in
            if error != nil {
                return
            }
            var pins = [MKPointAnnotation]()
            for doc in snap!.documents{
                    let map = doc.data()
                    let text = map["text"] as! String
                    let geoPoint = map["coordinates"] as! GeoPoint
                    let mkAnnotation = MKPointAnnotation()
                    mkAnnotation.title = text
                    mkAnnotation.coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
                    pins.append(mkAnnotation)
                }
            vc.updateMarkers(pins: pins)
        }
    }
    
    static func addMarker(title:String, lat:Double, lon:Double) {
        let ref = db.collection(path).document()
        var map = [String:Any]()
        map["text"] = title
        map["coordinates"] = GeoPoint(latitude: lat, longitude: lon)
        ref.setData(map)
        
    }
    
    
}

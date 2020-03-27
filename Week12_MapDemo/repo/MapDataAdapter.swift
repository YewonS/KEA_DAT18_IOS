//
//  MapDataAdapter.swift
//  MapDemo2020
//
//  Created by Yewon Seo on 2020/03/20.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

class MapDataAdapter {
    
    static func getMKAnnotationsFromData(snap: QuerySnapshot) -> [MKPointAnnotation] {
        var markers = [MKPointAnnotation]()
        
        for doc in snap.documents {
            print("received data: ")
            print(doc.documentID)
            let map = doc.data() // the data => map
            let text = map["text"] as! String
            print(text)
            let geoPoint = map["coordinates"] as! GeoPoint
            print(geoPoint)
            let mkAnnotation = MKPointAnnotation()
            mkAnnotation.title = text
            let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            mkAnnotation.coordinate = coordinate
            markers.append(mkAnnotation)
            
        }
        
       return markers // vc.updateMarkers(markers: markers)
    }

    
}

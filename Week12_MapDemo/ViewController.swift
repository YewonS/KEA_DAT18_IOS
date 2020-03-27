//
//  ViewController.swift
//  MapDemo2020
//
//  Created by Yewon Seo on 2020/03/20.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager() // will handle location(GPS, wifi) updates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // how precise
        
        createDemoMarker()
        FirebaseRepo.startListener(vc: self)
    
        
        
//        let region = MKCoordinateRegion(center: marker1, latitudinalMeters: 100, longitudinalMeters: 100)
//        map.setRegion(region, animated: true)
    }
    
    func updateMarkers(pins:[MKPointAnnotation]) { // we get raw data from firebaserepo
//        let markers = MapDataAdapter.getMKAnnotationsFromData(snap: snap)
        print("updating markers...")
        map.removeAnnotations(map.annotations)
        map.addAnnotations(pins)
        
    }
    
    fileprivate func createDemoMarker() {
        let marker = MKPointAnnotation() // create an empty marker
               marker.title = "Go here"
               let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5) // denmark
               marker.coordinate = location
               
               let marker1 = MKPointAnnotation()
               marker1.title = "home"
               marker1.coordinate = CLLocationCoordinate2D(latitude: 55.707505, longitude: 12.530336)
               marker1.subtitle = "my place in CPH"
               
               map.addAnnotation(marker) // maker where the user can click for more info
               map.addAnnotation(marker1)
    }
    
    @IBAction func startUpdate(_ sender: Any) {
        locationManager.startUpdatingLocation() // start getting location data from device
    }
    
    @IBAction func stopUpdate(_ sender: Any) {
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer){
        if sender.state == .ended  {
            let cgPoint = sender.location(in: map)
            let coordinate2D = map.convert(cgPoint, toCoordinateFrom: map)
            print("long pressed \(coordinate2D)")
            
            var name:String!
            let alert = UIAlertController(title: "Enter title", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: {
                textField in textField.placeholder = "Type in the title of pin"
            })
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                name = alert.textFields?.first?.text
                FirebaseRepo.addMarker(title:"test", lat: coordinate2D.latitude, lon: coordinate2D.longitude)
            }))
            
            self.present(alert, animated: true)
        }
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new location \(locations.first?.coordinate)")
        if let coordinate = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
            map.setRegion(region, animated: true)
        }
    }

}

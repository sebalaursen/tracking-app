//
//  ViewController.swift
//  coreloc
//
//  Created by Sebastian on /12/2/19.
//  Copyright © 2019 Sebastian Laursen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var locManager = CoreLocationManadger()
    var UserTrackingBtn: MKUserTrackingButton!
    var currentLocation: Coordinates?
    var locations: [CLLocationCoordinate2D] = []
    
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Map.delegate = self
        self.UserTrackingBtn = MKUserTrackingButton(mapView: Map)
    }
    
    func startTrackingCamPos() {
        if currentLocation != nil {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentLocation!.latitude, longitude: currentLocation!.longitude), latitudinalMeters: 5000, longitudinalMeters: 5000)
            Map.setRegion(region, animated: true)
        }
    }
    
    func draw() {
        locations.append(CLLocationCoordinate2D(latitude: currentLocation!.latitude, longitude: currentLocation!.longitude))
        Map.addOverlay(MKPolyline(coordinates: locations, count: locations.count))
    }
    
    @IBAction func StartTrackingBtn(_ sender: Any) {
        locManager.delegate = self
        locManager.startTracking()
        startTrackingCamPos()
    }
    
    @IBAction func StopTrackingBtn(_ sender: Any) {
        locManager.stopTracking()
    }
    
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let path = MKPolylineRenderer(overlay: overlay)
        path.strokeColor = .magenta
        path.lineWidth = 8
        return path //if i add more overlays, should check what overlay is coming in
    }
}

extension ViewController: CoreLocDelegate {
    func getCoordinates(location: Coordinates) {
       print("lat: \(location.latitude); lon: \(location.longitude)")
        currentLocation = location
        draw()
    }
    
    func alertLocationAccess() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need location tracking access",
            message: "Is needed to use this app",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

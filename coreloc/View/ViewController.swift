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
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UserTrackingBtn = MKUserTrackingButton(mapView: Map)
    }
    
    @IBAction func StartTrackingBtn(_ sender: Any) {
        locManager.delegate = self
        locManager.startTracking()
    }
    
    @IBAction func StopTrackingBtn(_ sender: Any) {
        locManager.stopTracking()
    }
    
}

extension ViewController: CoreLocDelegate {
    func getCoordinates(location: Coordinates) {
        print("lat: \(location.latitude); lon: \(location.longitude)")
    }
}

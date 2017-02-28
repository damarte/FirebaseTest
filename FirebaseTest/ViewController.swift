//
//  ViewController.swift
//  FirebaseTest
//
//  Created by David on 28/2/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: CustomMKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.showsScale = false
        self.mapView.showsTraffic = false
        self.mapView.showsBuildings = false
        self.mapView.showsPointsOfInterest = false
        self.mapView.showsCompass = false
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        //self.mapView.mapType = .satellite
        self.mapView.setUserTrackingMode(.followWithHeading, animated: true)

        manager.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? MKTileOverlay {
             return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        }
        else{
            return MKTileOverlayRenderer()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 100, 100)
        
        self.mapView.setRegion(region, animated: false)
        
        let camera = MKMapCamera()
        camera.centerCoordinate = self.mapView.centerCoordinate
        camera.pitch = 40.0
        camera.altitude = 100.0
        if let heading = self.mapView.userLocation.heading {
            camera.heading = heading.magneticHeading
        }
        mapView.setCamera(camera, animated: false
        )
        
        self.manager.stopUpdatingLocation()
    }
}


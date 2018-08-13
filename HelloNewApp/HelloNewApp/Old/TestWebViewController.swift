//
//  TestWebViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/21/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class TestWebViewController: UIViewController {

    fileprivate lazy var mapView: GMSMapView = {
        let mapView = GMSMapView()
        return mapView
    }()

    fileprivate var mapView2: GMSMapView!
     let locationManager = CLLocationManager()

    fileprivate let count: Int = {
        var test = 0
        test += 15
        test += 30
        return test
    }()

    var marker: GMSMarker!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(self.mapView)
        let camera = GMSCameraPosition.camera(withLatitude: 10.7949459, longitude: 106.6939918, zoom: 15.0)
        let cameraUpdate = GMSCameraUpdate.setCamera(camera)

        marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 10.7949459, longitude: 106.6939918))
        marker.map = mapView

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mapView.animate(with: cameraUpdate)
        }

        self.setupMyLocation()
    }

    func setupMyLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        if #available(iOS 9.0, *) {
            locationManager.requestLocation()
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 25
    }
}

extension TestWebViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let myLocation = locations.first else {return}

        marker.position = myLocation.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude, zoom: 15.0)
        let cameraUpdate = GMSCameraUpdate.setCamera(camera)
         self.mapView.animate(with: cameraUpdate)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }

}

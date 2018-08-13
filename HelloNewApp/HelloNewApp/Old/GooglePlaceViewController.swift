//
//  GooglePlaceViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/25/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker
import SVProgressHUD

class GooglePlaceViewController: UIViewController {

    var placesClient: GMSPlacesClient!

    // Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var attributionTextView: UITextView!



    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        placesClient = GMSPlacesClient.shared()
        locationManager.requestWhenInUseAuthorization()
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }

    // Add a UIButton in Interface Builder, and connect the action to this function.
    @IBAction func getCurrentPlace(_ sender: UIButton) {

//        SVProgressHUD.show()
//        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
//            SVProgressHUD.dismiss()
//
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                SVProgressHUD.showError(withStatus: error.localizedDescription)
//                return
//            }
//
//            self.nameLabel.text = "No current place"
//            self.addressLabel.text = ""
//
//            if let placeLikelihoodList = placeLikelihoodList {
//                let place = placeLikelihoodList.likelihoods.first?.place
//                if let place = place {
//                    self.nameLabel.text = place.name
//                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
//                        .joined(separator: "\n")
//                }
//            }
//        })
        self.pickPlace(sender)
    }

    @IBAction func pickPlace(_ sender: UIButton) {
       // 1. Center
        let center = CLLocationCoordinate2D(latitude: 10.7949459, longitude: 106.6852371)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.004, longitude: center.longitude + 0.004)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.004, longitude: center.longitude - 0.004)

        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)

        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }

            if let place = place {
                self.nameLabel.text = place.name
                self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                    .joined(separator: "\n")
                self.loadFirstPhotoForPlace(placeID: place.placeID)
            } else {
                self.nameLabel.text = "No place selected"
                self.addressLabel.text = ""
            }
        })
    }

    func loadFirstPhotoForPlace(placeID: String) {
        SVProgressHUD.show()
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            SVProgressHUD.dismiss()
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
                 SVProgressHUD.showError(withStatus: error.localizedDescription)
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        }
    }

    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        SVProgressHUD.show()
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            SVProgressHUD.dismiss()
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            } else {
                self.imageView.image = photo;
                self.attributionTextView.attributedText = photoMetadata.attributions;
            }
        })
    }

}

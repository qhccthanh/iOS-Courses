//
//  ViewController.swift
//  PhotoCamera
//
//  Created by Thanh Quach on 8/12/18.
//  Copyright © 2018 Thanh Quach. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    let imagePickerController: UIImagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePickerController.delegate = self

        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied || AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .restricted {
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            return
        }
    }

    @IBAction func didTapGetPhotoBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Chọn ảnh", message: "Chọn chế độ", preferredStyle: .actionSheet)

        let takePhotoAction = UIAlertAction(title: "Chụp ảnh", style: .default) { (_) in
            if UIImagePickerController.availableCaptureModes(for: .rear) == nil && UIImagePickerController.availableCaptureModes(for: .front) == nil {
                print("Máy không hổ trơ camera")
                return
            }

            self.imagePickerController.sourceType = .camera
            self.imagePickerController.cameraCaptureMode = .photo
            self.imagePickerController.modalPresentationStyle = .fullScreen

            self.present(self.imagePickerController, animated: true, completion: nil)
        }

        let libraryAction = UIAlertAction(title: "Lấy ảnh từ thư viện", style: .default) { (_) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }

        let cancelAction = UIAlertAction(title: "Đóng", style: .cancel, handler: nil)

        alertController.addAction(takePhotoAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}


extension ViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}

        self.photoImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
    }

}


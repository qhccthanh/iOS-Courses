//
//  DemoCollectionViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/11/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class DemoCollectionViewController: UIViewController {

    var currentImage: UIImage?
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // https://www.cbronline.com/wp-content/uploads/2016/05/iOS.jpg
        let url = URL(string: "https://www.cbronline.com/wp-content/uploads/2016/05/iOS.jpg")
        let task =  URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            if let data = data,
                let image = UIImage(data: data) {
                self.currentImage = image
                // refresh collection
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    // self.imageVirew.image = image
                }
            }
        }
        task.resume()

    }
}

extension DemoCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellA", for: indexPath) // UICollectionViewCell

        if let imageView = cell.viewWithTag(101) as? UIImageView {
            imageView.image = self.currentImage
        }

        return cell
    }

}

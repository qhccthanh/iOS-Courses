//
//  ViewController.swift
//  Animation
//
//  Created by Thanh Quach on 8/12/18.
//  Copyright © 2018 Thanh Quach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var viewA: UIView = UIView()
    fileprivate var viewB: UIView = UIView()
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.addSubview(viewA)
//        self.view.addSubview(viewB)
//        viewA.frame = CGRect(x: 100, y: 200, width: 200, height: 100)
//
//        viewB.frame = CGRect(x: 100, y: 500, width: 300, height: 300)
//        viewA.backgroundColor = .red
//
//        self.startChangeColorAnimation()
//        self.startChangeAlphaAnimation()
//        self.startChangePositionAnimation()
//        self.startChangeScaleTransformAnimation()
//
//        let pulsator = Pulsator()
//        pulsator.numPulse = 5
//        viewB.layer.addSublayer(pulsator)
//        pulsator.start()

        NotificationCenter.default.addObserver(self, selector: #selector(self.defaultSelector), name: Notification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.defaultSelector), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.defaultSelector), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        // 217
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            bottomConstraint.constant = keyboardHeight + 20
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardDidHide(_ notification: Notification) {
        bottomConstraint.constant = 20
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func defaultSelector() {

    }

    func startChangeColorAnimation() {

        let changeColor = self.viewA.backgroundColor == .red ? UIColor.blue : UIColor.red
        UIView.animate(withDuration: 1, animations: {
            self.viewA.backgroundColor = changeColor
        }) { (_) in
            self.startChangeColorAnimation()
        }
    }

    func startChangeAlphaAnimation() {
        let changeAlpha = self.viewA.alpha == 0.2 ? 1.0 : 0.2
        UIView.animate(withDuration: 1.5, animations: {
            self.viewA.alpha = CGFloat(changeAlpha)
        }) { (_) in
            self.startChangeAlphaAnimation()
        }
    }

    func startChangePositionAnimation() {

        let changeX = self.viewA.frame.origin.x == 0 ? self.view.bounds.width - self.viewA.bounds.width : 0
        UIView.animate(withDuration: 2.5, animations: {
            self.viewA.frame.origin.x = changeX
        }) { (_) in
            self.startChangePositionAnimation()
        }
    }

    func startChangeScaleTransformAnimation() {

        let originTransform = self.viewA.transform
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0, options: [], animations: {
            self.viewA.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.viewA.transform = CGAffineTransform(rotationAngle: 90)
        }) { (_) in
            self.startChangeScaleTransformAnimation()
            self.viewA.transform = originTransform
        }

    }
}


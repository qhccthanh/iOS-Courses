//
//  HelloTextField.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/4/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

@IBDesignable
class HelloTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    func setup() {
        let view = loadViewFromNib()
        view.frame = bounds

        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                 UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle.main

        let nib = UINib(nibName: "HelloTextField", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }

}

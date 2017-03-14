//
//  TapToCloseViewController.swift
//  CAShapeLayerDemo
//
//  Created by Guanshan Liu on 27/2/15.
//  Copyright (c) 2015 Guanshan Liu. All rights reserved.
//

import UIKit

class TapToCloseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(TapToCloseViewController.onTapGesture))
        view.addGestureRecognizer(tap)

        view.backgroundColor = .white
    }

    func onTapGesture() {
        dismiss(animated: true, completion: nil)
    }

}

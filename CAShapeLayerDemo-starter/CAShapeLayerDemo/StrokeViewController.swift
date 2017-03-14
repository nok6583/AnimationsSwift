//
//  StrokeViewController.swift
//  CAShapeLayerDemo
//
//  Created by Guanshan Liu on 27/2/15.
//  Copyright (c) 2015 Guanshan Liu. All rights reserved.
//

import UIKit

class StrokeViewController: TapToCloseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)

        // Create CAShapeLayerS
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = view.center
        rectShape.cornerRadius = bounds.width / 2
        view.layer.addSublayer(rectShape)

        // Apply effects here
        // 1
        rectShape.path = UIBezierPath(ovalIn: rectShape.bounds).cgPath
        
        rectShape.lineWidth = 4.0
        
        rectShape.strokeColor = UIColor.lightGray.cgColor
        rectShape.fillColor = UIColor.clear.cgColor
        
        // 2
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 0.5
        
        // 3
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = 1.5
        group.autoreverses = true
        group.repeatCount = HUGE // repeat forver
        rectShape.add(group, forKey: nil)
    }

}

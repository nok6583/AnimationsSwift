//
//  ComplexShapeViewController.swift
//  CAShapeLayerDemo
//
//  Created by DALIBON Maxime on 20/02/2017.
//  Copyright © 2017 Guanshan Liu. All rights reserved.
//

import UIKit

class ComplexShapeViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // the complex bezier path
        let initialPoint = CGPoint(x: 0, y: 0)
        let curveStart = CGPoint(x: 0, y: (rect.size.height) * (0.2))
        let curveControl = CGPoint(x: (rect.size.width) * (0.6), y: (rect.size.height) * (0.5))
        let curveEnd = CGPoint(x: 0, y: (rect.size.height) * (0.8))
        let firstCorner = CGPoint(x: 0, y: rect.size.height)
        let secondCorner = CGPoint(x: rect.size.width, y: rect.size.height)
        let thirdCorner = CGPoint(x: rect.size.width, y: 0)
        
        var myBezierArc = UIBezierPath()
        myBezierArc.moveToPoint(initialPoint)
        myBezierArc.addLineToPoint(curveStart)
        myBezierArc.addQuadCurveToPoint(curveEnd, controlPoint: curveControl)
        myBezierArc.addLineToPoint(firstCorner)
        myBezierArc.addLineToPoint(secondCorner)
        myBezierArc.addLineToPoint(thirdCorner)
        
        // Animation
        let myAnimation = CABasicAnimation(keyPath: "path")
        
        if (isArcVisible == true) {
            myAnimation.fromValue = myBezierArc.CGPath
            myAnimation.toValue = myBezierTrivial.CGPath
        } else {
            myAnimation.fromValue = myBezierTrivial.CGPath
            myAnimation.toValue = myBezierArc.CGPath
        }
        myAnimation.duration = 0.4
        myAnimation.fillMode = kCAFillModeForwards
        myAnimation.removedOnCompletion = false
        
        myImageView.layer.mask.addAnimation(myAnimation, forKey: "animatePath")
    }
    
}

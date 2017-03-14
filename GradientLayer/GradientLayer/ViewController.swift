//
//  ViewController.swift
//  GradientLayer
//
//  Created by DALIBON Maxime on 01/03/2017.
//  Copyright © 2017 DALIBON Maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var colorSets = [[CGColor]]()
    var currentColorSet: Int!
    var gradientLayer: CAGradientLayer!
    var gradientCircleLayer: WCGraintCircleLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //createColorSets()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ViewController.handleTapGesture))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //createGradientLayer()
        createGradientCircleLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradientCircleLayer () {
        gradientCircleLayer = WCGraintCircleLayer(bounds: CGRect(origin: CGPoint.zero,size:CGSize(width: 150, height: 150)), position: CGPoint(x: self.view.frame.size.width/2-50, y: self.view.frame.size.height/2-50), fromColor: UIColor.blue, toColor: UIColor.green, linewidth: 10.0, toValue: 0.0)
        self.view.layer.addSublayer(gradientCircleLayer)
        gradientCircleLayer.animateCircleTo(duration: 3.0, fromValue: 0, toValue: 0.99)
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func createColorSets() {
        colorSets.append([UIColor.red.cgColor, UIColor.yellow.cgColor])
        colorSets.append([UIColor.green.cgColor, UIColor.magenta.cgColor])
        colorSets.append([UIColor.gray.cgColor, UIColor.lightGray.cgColor])
        
        currentColorSet = 0
    }

    func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        if currentColorSet < colorSets.count - 1 {
            currentColorSet! += 1
        }
        else {
            currentColorSet = 0
        }
        
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = 2.0
        colorChangeAnimation.toValue = colorSets[currentColorSet]
        colorChangeAnimation.fillMode = kCAFillModeForwards
        colorChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
    }

}


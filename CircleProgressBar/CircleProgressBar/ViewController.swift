//
//  ViewController.swift
//  CircleProgressBar
//
//  Created by DALIBON Maxime on 03/03/2017.
//  Copyright © 2017 DALIBON Maxime. All rights reserved.
//

import UIKit
import KDCircularProgress

class ViewController: UIViewController {

    var progress: KDCircularProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        self.progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.3
        progress.clockwise = true
        progress.gradientRotateSpeed = 5
        progress.roundedCorners = true
        progress.glowMode = .reverse
        progress.glowAmount = 0.3
        progress.set(colors: Colors.greenYellow ,Colors.green)
        progress.center = CGPoint(x: view.center.x, y: view.center.y + 15)
        view.addSubview(progress)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func action(_ sender: Any) {
        progress.animate(toAngle: 360, duration: 0.5) { (true) in
            self.progress.angle = 0
        }
        
    }

}


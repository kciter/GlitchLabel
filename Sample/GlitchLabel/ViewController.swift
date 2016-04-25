//
//  ViewController.swift
//  GlitchLabel
//
//  Created by LeeSunhyoup on 2016. 4. 22..
//  Copyright © 2016년 Lee Sun-Hyoup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var glitchLabel: GlitchLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        If white background
        glitchLabel.blendMode = .Multiply
        view.backgroundColor = UIColor.whiteColor()
    }
}
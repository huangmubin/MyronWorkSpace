//
//  ViewController.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/7/31.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegueWithIdentifier("ValueViewController", sender: nil)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Done")
    }
}

extension UIInterfaceOrientationMask {
    
    func orientations() -> [UIInterfaceOrientation] {
        switch self {
        case UIInterfaceOrientationMask.Portrait:
            return [UIInterfaceOrientation.Portrait]
        case UIInterfaceOrientationMask.LandscapeRight:
            return [UIInterfaceOrientation.LandscapeRight]
        case UIInterfaceOrientationMask.LandscapeLeft:
            return [UIInterfaceOrientation.LandscapeLeft]
        case UIInterfaceOrientationMask.PortraitUpsideDown:
            return [UIInterfaceOrientation.PortraitUpsideDown]
        case UIInterfaceOrientationMask.Landscape:
            return [UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight]
        case UIInterfaceOrientationMask.All:
            return [UIInterfaceOrientation.Portrait, UIInterfaceOrientation.PortraitUpsideDown, UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight]
        case UIInterfaceOrientationMask.AllButUpsideDown:
            return [UIInterfaceOrientation.Portrait, UIInterfaceOrientation.PortraitUpsideDown, UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight]
        default:
            return []
        }
    }
}

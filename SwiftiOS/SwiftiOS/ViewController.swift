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
        //performSegueWithIdentifier("ValueViewControlller", sender: nil)
        
        print("Portrait: \(UIInterfaceOrientationMask.Portrait.rawValue)")
        print("LandscapeLeft: \(UIInterfaceOrientationMask.LandscapeLeft.rawValue)")
        print("LandscapeRight: \(UIInterfaceOrientationMask.LandscapeRight.rawValue)")
        print("PortraitUpsideDown: \(UIInterfaceOrientationMask.PortraitUpsideDown.rawValue)")
        print("Landscape: \(UIInterfaceOrientationMask.Landscape.rawValue)")
        print("All: \(UIInterfaceOrientationMask.All.rawValue)")
        print("AllButUpsideDown: \(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)")
        print("")
        print("Unknown \(UIInterfaceOrientation.Unknown.rawValue)")
        print("Portrait \(UIInterfaceOrientation.Portrait.rawValue)")
        print("PortraitUpsideDown \(UIInterfaceOrientation.PortraitUpsideDown.rawValue)")
        print("LandscapeLeft \(UIInterfaceOrientation.LandscapeLeft.rawValue)")
        print("LandscapeRight \(UIInterfaceOrientation.LandscapeRight.rawValue)")
        print("")
        print("\(Int(UIInterfaceOrientationMask.Portrait.rawValue) == 1 << UIInterfaceOrientation.Portrait.rawValue)")
        print("\(Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue) == 1 << UIInterfaceOrientation.LandscapeLeft.rawValue)")
        print("\(Int(UIInterfaceOrientationMask.LandscapeRight.rawValue) == 1 << UIInterfaceOrientation.LandscapeRight.rawValue)")
        print("\(Int(UIInterfaceOrientationMask.PortraitUpsideDown.rawValue) == 1 << UIInterfaceOrientation.PortraitUpsideDown.rawValue)")
        
        
        print("\(UIInterfaceOrientationMask.Landscape.rawValue == UIInterfaceOrientationMask.LandscapeLeft.rawValue | UIInterfaceOrientationMask.LandscapeRight.rawValue)")
        print("\(UIInterfaceOrientationMask.All.rawValue == UIInterfaceOrientationMask.LandscapeLeft.rawValue | UIInterfaceOrientationMask.LandscapeRight.rawValue | UIInterfaceOrientationMask.Portrait.rawValue | UIInterfaceOrientationMask.PortraitUpsideDown.rawValue)")
        print("\(UIInterfaceOrientationMask.AllButUpsideDown.rawValue == UIInterfaceOrientationMask.LandscapeLeft.rawValue | UIInterfaceOrientationMask.LandscapeRight.rawValue | UIInterfaceOrientationMask.Portrait.rawValue)")
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

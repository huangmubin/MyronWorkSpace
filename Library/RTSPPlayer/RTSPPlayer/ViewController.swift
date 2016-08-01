//
//  ViewController.swift
//  RTSPPlayer
//
//  Created by 黄穆斌 on 16/8/1.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FFMpegPlayerDelegate {

    var imageView = UIImageView()
    var player: FFMpegPlayer!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        player = FFMpegPlayer(view: imageView, delegate: self)
        player.play()
        print("viewDidAppear")
    }
    
    
    func FFMpegPlayerUrl() -> String {
        return "rtsp://192.168.42.1/preview"
    }
    func FFMpegPlayerDidChangedStatus(status: FFMpegPlayerStatus) {
        switch status {
        case .Loading:
            print("FFMpegPlayerDidChangedStatus Loading")
        case .Playing:
            print("FFMpegPlayerDidChangedStatus Playing")
        case .Stoped:
            print("FFMpegPlayerDidChangedStatus Stoped")
        }
    }
    func FFMpegPlayerDidError(error: String) {
        print("FFMpegPlayerDidError \(error)")
    }
}


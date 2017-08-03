//
//  ViewController.swift
//  Proximity
//
//  Created by Xcode on 2017/5/1.
//  Copyright © 2017年 wtfcompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var textLabel: UILabel!
    var timesLabel: UILabel!
    var imageView: UIImageView!
    var count: Int = 0 {
        didSet {
            self.timesLabel.text = "次數  \(count)"
            self.imageView.image = self.imageArray[self.count % 5]
        }
    }
    let imageArray = [
        UIImage(named: "normal"),
        UIImage(named: "down"),
        UIImage(named: "headdown"),
        UIImage(named: "headup"),
        UIImage(named: "up")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenW = UIScreen.main.bounds.width
        self.textLabel = UILabel(frame: CGRect(x: 0, y: 150, width: screenW, height: 50))
        self.textLabel.textAlignment = .center
        self.textLabel.text = "晃動與接近"
        self.textLabel.textColor = UIColor.darkGray
        self.textLabel.font = UIFont.systemFont(ofSize: 40)
        self.view.addSubview(self.textLabel)
        
        self.timesLabel = UILabel(frame: CGRect(x: 0, y: textLabel.frame.maxY + 10, width: screenW, height: 50))
        self.timesLabel.textAlignment = .center
        self.timesLabel.textColor = UIColor.darkGray
        self.timesLabel.text = "次數  \(count)"
        self.timesLabel.font = UIFont.systemFont(ofSize: 40)
        self.view.addSubview(self.timesLabel)
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW * 0.5, height: screenW * 0.5))
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.center = view.center
        self.imageView.image = imageArray[0]

        self.view.addSubview(imageView)
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("\(#function) - \(self.count)")
            self.count += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIDevice.current.isProximityMonitoringEnabled = true
        if UIDevice.current.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityStateChanged), name: .UIDeviceProximityStateDidChange, object: nil)
        }else {
            print("裝置不支援")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//MARK: -selector
    func proximityStateChanged() {
        if UIDevice.current.proximityState {
            print("接近")
            self.count = 0
        }else {
            print("遠離")
        }
    }
}


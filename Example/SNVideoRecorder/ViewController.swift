//
//  ViewController.swift
//  SNVideoRecorder
//
//  Created by Dair Diaz on 08/24/2017.
//  Copyright (c) 2017 Dair Diaz. All rights reserved.
//

import UIKit
import SNVideoRecorder

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openHandler(_ sender: Any) {
        let vc = SNVideoRecorderViewController()
        vc.delegate = self
        
        // flashlight icons
        vc.flashLightOnIcon = UIImage(named: "flash_light_50")
        vc.flashLightOffIcon = UIImage(named: "flash_light_off_50")
        
        // switch camera icon
        vc.switchCameraOption.setImage(UIImage(named: "switch_camera_50")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        // close options
        vc.closeOption.isHidden = true
        vc.closeOption.setImage(UIImage(named: "delete_50")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        // preview text
        vc.agreeText = "ok"
        vc.discardText = "discard"
        
        // max seconds able to record
        vc.maxSecondsToRecord = 58
        
        // start camera position
        vc.initCameraPosition = .front
        
        // show up
        present(vc, animated: true, completion: nil)
    }
}

extension ViewController: SNVideoRecorderDelegate {
    
    func videoRecorder(withVideo url: URL) {
        print(url)
    }
    
    func videoRecorder(withImage image: UIImage) {
        print(image)
    }
}

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
        vc.flashLightOnIcon = UIImage(named: "flash_light_50")
        vc.flashLightOffIcon = UIImage(named: "flash_light_off_50")
        vc.closeOption.isHidden = true
        vc.flashLightOption.setImage(UIImage(named: "flash_light_50")?.withRenderingMode(.alwaysTemplate), for: .normal)
        vc.switchCameraOption.setImage(UIImage(named: "switch_camera_50")?.withRenderingMode(.alwaysTemplate), for: .normal)
        vc.closeOption.setImage(UIImage(named: "delete_50")?.withRenderingMode(.alwaysTemplate), for: .normal)
        vc.agreeText = "ok"
        vc.discardText = "discard"
        vc.maxSecondsToRecord = 58
        vc.initCameraPosition = .front
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

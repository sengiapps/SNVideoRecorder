//
//  SNVideoRecorderDelegate.swift
//  Pods
//
//  Created by Dair Diaz on 24/08/17.
//
//

import Foundation

public protocol SNVideoRecorderDelegate: class {
    func videoRecorder(withImage image:UIImage)
    func videoRecorder(withVideo url:URL)
}

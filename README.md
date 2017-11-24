# SNVideoRecorder

This is a small whatsapp-like library to record video and take pictures.
[![Version](https://img.shields.io/cocoapods/v/SNVideoRecorder.svg?style=flat)](http://cocoapods.org/pods/SNVideoRecorder)
[![License](https://img.shields.io/cocoapods/l/SNVideoRecorder.svg?style=flat)](http://cocoapods.org/pods/SNVideoRecorder)
[![Platform](https://img.shields.io/cocoapods/p/SNVideoRecorder.svg?style=flat)](http://cocoapods.org/pods/SNVideoRecorder)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SNVideoRecorder is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SNVideoRecorder"
```

## Basic use

```swift
// implement the protocol SNVideoRecorderDelegate
extension ViewController: SNVideoRecorderDelegate {
    func videoRecorder(withVideo url: URL) {
        print(url) // url for the video
    }
    func videoRecorder(withImage image: UIImage) {
        print(image) // image
    }
}

// then in your controller use some like this
let vc = SNVideoRecorderViewController()
vc.delegate = self

// flashlight icons
vc.flashLightOnIcon = UIImage(named: "flash_light_50")
vc.flashLightOffIcon = UIImage(named: "flash_light_off_50")

// switch camera icon
vc.switchCameraOption.setImage(UIImage(named:"switch_camera_50")?.withRenderingMode(.alwaysTemplate), for: .normal)

// close options
vc.closeOption.isHidden = true
vc.closeOption.setImage(UIImage(named:"delete_50")?.withRenderingMode(.alwaysTemplate), for: .normal)

// preview controller options label
vc.agreeText = "ok"
vc.discardText = "discard"

// max seconds able to record
vc.maxSecondsToRecord = 58

// init camera position
vc.initCameraPosition = .front

// show up
present(vc, animated: true, completion: nil)
```

## License

SNVideoRecorder is available under the MIT license. See the LICENSE file for more info.


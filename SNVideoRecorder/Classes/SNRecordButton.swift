//
//  SNRecordButton.swift
//  Pods
//
//  Created by Dair Diaz on 24/08/17.
//
//

import UIKit

protocol SNRecordButtonDelegate: class {
    func didStart(mode:SNCaptureMode)
    func didEnd(isCanceled:Bool)
}

class SNRecordButton: UIView {
    weak var delegate:SNRecordButtonDelegate?
    var isEnabled:Bool = true
    let maxScale:CGFloat = 1.5
    let showUpRedCircleAnimation:CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.2
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        return animation
    }()
    let hideRedCircleAnimation:CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.2
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        return animation
    }()
    var longTouchGesture:UILongPressGestureRecognizer?
    var tapGesture:UITapGestureRecognizer?
    
    // components
    let redCircle = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .clear
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
        
        redCircle.fillColor = UIColor.red.cgColor
        layer.addSublayer(redCircle)
        
        longTouchGesture = UILongPressGestureRecognizer(target: self, action: #selector
            (longGestureHandler))
        addGestureRecognizer(longTouchGesture!)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabGestureHandler))
        tapGesture?.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture!)
    }
    
    func cancel() {
        hide(isCanceled: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
    }
    
    @objc func longGestureHandler(gesture:UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            if isEnabled {
                show(mode: .video)
            }
        case .cancelled, .ended, .failed:
            if isEnabled {
                hide(isCanceled: false)
            }
        default:
            break
        }
    }
    
    @objc func tabGestureHandler(gesture:UITapGestureRecognizer) {
        if isEnabled {
            delegate?.didStart(mode: .photo)
        }
    }
    
    fileprivate func show(mode:SNCaptureMode) {
        let center = CGPoint(x: frame.width / 2,y: frame.height / 2)
        let circlePath = UIBezierPath(arcCenter: center, radius: center.x, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        redCircle.path = circlePath.cgPath
        
        redCircle.add(showUpRedCircleAnimation, forKey: "show")
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: self.maxScale, y: self.maxScale)
        }) { (isDone) in
            self.delegate?.didStart(mode: mode)
        }
    }
    
    fileprivate func hide(isCanceled:Bool) {
        hideRedCircleAnimation.delegate = self
        redCircle.add(hideRedCircleAnimation, forKey: "hide")
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
        }) { (isDone) in
            self.delegate?.didEnd(isCanceled: isCanceled)
        }
    }
}

extension SNRecordButton: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        redCircle.path = nil
    }
}


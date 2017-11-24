//
//  SNRecordingCountDown.swift
//  Pods
//
//  Created by Dair Diaz on 24/08/17.
//
//

import UIKit

protocol SNRecordingCountDownDelegate: class {
    func countDown(didStartAt time:TimeInterval)
    func countDown(didFinishAt time:TimeInterval)
    func countDown(didPauseAt time:TimeInterval)
}

class SNRecordingCountDown: UIView {
    weak var delegate:SNRecordingCountDownDelegate?
    
    var seconds = 15
    var timer = Timer()
    
    // components
    let label:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "00:00"
        l.font = .systemFont(ofSize: 12)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        addViews()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
    func addViews() {
        addSubview(label)
    }
    
    func setupViews() {
        // label
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 2).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -2).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setup(seconds:Int) {
        self.seconds = seconds
        label.text = timeString(time: TimeInterval(seconds))
    }
    
    func start(on:Int) {
        seconds = on
        label.text = timeString(time: TimeInterval(seconds))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerHandler), userInfo: nil, repeats: true)
        delegate?.countDown(didStartAt: TimeInterval(seconds))
    }
    
    func pause() {
        timer.invalidate()
        delegate?.countDown(didPauseAt: TimeInterval(seconds))
    }
    
    @objc func updateTimerHandler() {
        seconds -= 1
        label.text = timeString(time: TimeInterval(seconds))
        
        if seconds == 0 {
            timer.invalidate()
            delegate?.countDown(didFinishAt: TimeInterval(seconds))
        }
    }
    
    fileprivate func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}


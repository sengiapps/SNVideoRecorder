//
//  SNVideoViewerViewController.swift
//  Pods
//
//  Created by Dair Diaz on 24/08/17.
//
//
import UIKit
import AVFoundation

protocol SNVideoViewerDelegate: class {
    func videoView(finishWithAgree agree:Bool, andURL url:URL?)
}

class SNVideoViewerViewController: UIViewController {
    var url:URL?
    weak var delegate:SNVideoViewerDelegate?
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // components
    var player:AVPlayer?
    var playerLayer:AVPlayerLayer?
    let agreeOption:UIButton = {
        let v = UIButton(type: .custom)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle(NSLocalizedString("Ok", comment: ""), for: .normal)
        v.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        return v
    }()
    let discardOption:UIButton = {
        let v = UIButton(type: .custom)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle(NSLocalizedString("Discard", comment: ""), for: .normal)
        v.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        addViews()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let value = url {
            player = AVPlayer(url: value)
            playerLayer = AVPlayerLayer(player: player!)
            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            view.layer.insertSublayer(playerLayer!, at: 0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player?.play()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        playerLayer?.frame = view.frame
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
    func addViews() {
        view.addSubview(agreeOption)
        view.addSubview(discardOption)
        
        agreeOption.addTarget(self, action: #selector(agreeHandler), for: .touchUpInside)
        discardOption.addTarget(self, action: #selector(discardHandler), for: .touchUpInside)
    }
    
    func setupViews() {
        // ok
        agreeOption.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        agreeOption.heightAnchor.constraint(equalToConstant: 45).isActive = true
        agreeOption.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agreeOption.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // cancel
        discardOption.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        discardOption.heightAnchor.constraint(equalTo: agreeOption.heightAnchor).isActive = true
        discardOption.leftAnchor.constraint(equalTo: agreeOption.rightAnchor).isActive = true
        discardOption.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc func agreeHandler(sender:UIButton) {
        dismiss(animated: false) {
            self.delegate?.videoView(finishWithAgree: true, andURL: self.url)
        }
    }
    
    @objc func discardHandler(sender:UIButton) {
        dismiss(animated: false) {
            self.delegate?.videoView(finishWithAgree: false, andURL: self.url)
        }
    }
}


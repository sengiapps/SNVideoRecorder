//
//  SNImageViewerViewController.swift
//  Pods
//
//  Created by Dair Diaz on 24/08/17.
//
//

import UIKit

protocol SNImageViewerDelegate: class {
    func imageView(finishWithAgree agree:Bool, andImage image:UIImage?)
}

class SNImageViewerViewController: UIViewController {
    var image:UIImage?
    weak var delegate:SNImageViewerDelegate?
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // components
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
    var imageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        addViews()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        imageView?.contentMode = .scaleAspectFit
        view.insertSubview(imageView!, at: 0)
        imageView?.image = image
        imageView?.isUserInteractionEnabled = true
        imageView?.center = CGPoint(x: view.center.x, y: view.center.y)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler))
        panGesture.delegate = self
        imageView?.addGestureRecognizer(panGesture)
        panGesture.cancelsTouchesInView = false
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandler))
        pinchGesture.delegate = self
        imageView?.addGestureRecognizer(pinchGesture)
        pinchGesture.cancelsTouchesInView = false
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
    
    @objc func pinchGestureHandler(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            let currentScale: CGFloat = gesture.view?.layer.value(forKeyPath: "transform.scale.x") as! CGFloat
            let minScale:CGFloat = 0.5
            let maxScale:CGFloat = 2.0
            let zoomSpeed:CGFloat = 0.5
            
            var deltaScale = gesture.scale
            
            deltaScale = ((deltaScale - 1) * zoomSpeed) + 1
            deltaScale = min(deltaScale, maxScale / currentScale)
            deltaScale = max(deltaScale, minScale / currentScale)
            
            let zoomTransform = (gesture.view?.transform)!.scaledBy(x: deltaScale, y: deltaScale)
            gesture.view?.transform = zoomTransform
            gesture.scale = 1
        }
    }
    
    @objc func panGestureHandler(gesture:UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view?.superview)
        if gesture.state == .began || gesture.state == .changed {
            gesture.view?.center = CGPoint(x: (gesture.view?.center.x)! + translation.x, y: (gesture.view?.center.y)! + translation.y)
            gesture.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc func agreeHandler(sender:UIButton) {
        dismiss(animated: false) {
            self.delegate?.imageView(finishWithAgree: true, andImage: self.image)
        }
    }
    
    @objc func discardHandler(sender:UIButton) {
        dismiss(animated: false) {
            self.delegate?.imageView(finishWithAgree: false, andImage: self.image)
        }
    }
}

extension SNImageViewerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

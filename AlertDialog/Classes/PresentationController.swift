//
//  PresentationController.swift
//  AlertController
//
//  Created by 胡红星 on 2022/8/25.
//

import Foundation

public class PresentationController: UIPresentationController {
    private lazy var dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.backgroundColor = UIColor(red: 49 / 255, green: 55 / 255, blue: 66 / 255, alpha: 1)
        return dimmingView
    }()
    
    public override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in            
            self?.dimmingView.alpha = 0.6
        })
    }
    
    public override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 0
        }, completion: nil)
    }
}

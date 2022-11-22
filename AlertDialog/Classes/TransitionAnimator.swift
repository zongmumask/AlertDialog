//
//  TransitionAnimator.swift
//  AlertController
//
//  Created by 胡红星 on 2022/8/25.
//

import Foundation

@objc public enum AnimationDirection: Int {
    case `in`
    case out
}

public class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
     let direction: AnimationDirection
    
    @objc public init(direction: AnimationDirection) {
        self.direction = direction
        super.init()
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return direction == .in ? 0.22 : 0.2
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        let isPresenting = to.presentingViewController == from
        
        if isPresenting {
            containerView.addSubview(to.view)
            to.view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            to.view.alpha = 0
            UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                to.view.transform = CGAffineTransform.identity
                to.view.alpha = 1
            } completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                from.view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                from.view.alpha = 0
            } completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}

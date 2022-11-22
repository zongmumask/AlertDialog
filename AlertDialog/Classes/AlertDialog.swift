//
//  AlertController.swift
//  AlertController
//
//  Created by 胡红星 on 2022/8/23.
//

import Foundation

public class AlertDialog: UIViewController, UIViewControllerTransitioningDelegate {
    
    private let textColor: UIColor = UIColor(red: 41 / 255, green: 48 / 255, blue: 64 / 255, alpha: 1)
    
    private let containerWidth: CGFloat = 260
    private let contentMargin: CGFloat = 26
    private let verticalTitleTopSpace: CGFloat = 20
    private let VerticalTitleBottomSpace: CGFloat = 15
    private let VerticalElementSpace: CGFloat = 30
    private let buttonHeight: CGFloat = 44
    private var maxMessageContentSizeHeight: CGFloat {
        get {
            return UIScreen.main.bounds.size.height / 2
        }
    }
    
    private var initialized = false
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 8
        container.layer.masksToBounds = true
        return container
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = textColor
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = textColor
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var buttons: [ActionButton] = {
        return [ActionButton]()
    }()
    
    private var alertView: UIView?
    private var titleText: String?
    private var message: String?
    
    @objc public init(title: String?, message: String?) {
        
        self.message = message
        titleText = title
        
        super.init(nibName: nil, bundle: nil)
        
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    @objc public init(alertView: UIView?) {
        self.alertView = alertView
        super.init(nibName: nil, bundle: nil)
        
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard !initialized else { return }
        
        setupViews()
        initialized = true
    }
    
    func setupViews() {
        view.addSubview(containerView)
        
        var yOffset: CGFloat = 0
        
        if let alertView = alertView {
            containerView.addSubview(alertView)
            yOffset = alertView.bounds.maxY
        } else {
            yOffset = verticalTitleTopSpace
            if let titleText = titleText {
                titleLabel.text = titleText
                let size = boundingSize(text: titleText, font: titleLabel.font, maxWidth: containerWidth - 2 * contentMargin)
                titleLabel.frame = CGRect(x: contentMargin, y: yOffset, width: containerWidth - 2 * contentMargin, height: size.height)
                containerView.addSubview(titleLabel)
                yOffset = titleLabel.frame.maxY
            }
            if let message = message {
                messageLabel.text = message
                let size = boundingSize(text: message, font: messageLabel.font, maxWidth: containerWidth - 2 * contentMargin)
                messageLabel.frame = CGRect(x: 0, y: 0, width: containerWidth - 2 * contentMargin, height: 0)
                if size.height < maxMessageContentSizeHeight {
                    messageLabel.frame = CGRect(origin: CGPoint(x: contentMargin, y: yOffset + VerticalTitleBottomSpace), size: size)
                    containerView.addSubview(messageLabel)
                    yOffset = messageLabel.frame.maxY
                } else {
                    let messageScrollView = UIScrollView(frame: CGRect(x: contentMargin, y: yOffset + VerticalTitleBottomSpace, width: containerWidth - contentMargin * 2, height: maxMessageContentSizeHeight))
                    messageScrollView.isScrollEnabled = true
                    messageScrollView.contentSize = size
                    messageScrollView.addSubview(messageLabel)
                    containerView.addSubview(messageScrollView)
                    yOffset = messageScrollView.frame.maxY
                }
            }
        }
        
        let lineView = UIView(frame: CGRect(x: 0, y: yOffset + VerticalElementSpace, width: containerWidth, height: 0.5))
        lineView.backgroundColor = UIColor(red: 238 / 255, green: 238 / 255, blue: 238 / 255, alpha: 1)
        containerView.addSubview(lineView)
        yOffset = lineView.frame.maxY
        
        let buttonWidth: CGFloat = containerWidth / CGFloat(buttons.count)
        for (idx, button) in buttons.enumerated() {
            button.frame = CGRect(x: buttonWidth * CGFloat(idx), y: yOffset, width: buttonWidth, height: buttonHeight)
            containerView.addSubview(button)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        yOffset += buttonHeight
        
        containerView.frame = CGRect(x: 0, y: 0, width: containerWidth, height: yOffset)
        containerView.center = view.center
    }
    
    func boundingSize(text: String?, font: UIFont, maxWidth: CGFloat) -> CGSize {
        guard let text = text else {
            return .zero
        }
                
        let bounds = text.boundingRect(with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return bounds.size
    }
    
    @objc func buttonTapped(_ button: ActionButton) {
        if button.dismissOnTap  {
            dismiss(animated: true) {
                button.action?()
            }
        } else {
            button.action?()
        }
    }
    
    @objc public func addButton(_ button: ActionButton) {
        buttons.append(button)
    }
    
    @objc public func addButtons(_ buttons: [ActionButton]) {
        self.buttons += buttons
    }
}

extension AlertDialog {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(direction: .in)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(direction: .out)
    }
}

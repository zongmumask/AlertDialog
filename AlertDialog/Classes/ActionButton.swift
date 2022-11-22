//
//  ActionButton.swift
//  AlertController
//
//  Created by 胡红星 on 2022/8/25.
//

import Foundation

@objc public enum ButtonStyle: Int {
    case cancel
    case confirm
}

public class ActionButton: UIButton {
    
    public typealias ButtonAction = () -> Void
    
    var buttonStyle: ButtonStyle
    var action: ButtonAction?
    @objc public var dismissOnTap: Bool = true
    
    @objc public init(style: ButtonStyle, title: String?, action: ButtonAction?) {
        
        buttonStyle = style
        self.action = action
        super.init(frame: .zero)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setTitle(title, for: .normal)
        
        setupView()
    }
    
    @objc public convenience init(style: ButtonStyle) {
        self.init(style: style, title: style == .cancel ? "取消" : "确定", action: nil)
    }
    
    @objc public convenience init(style: ButtonStyle, action:ButtonAction?) {
        self.init(style: style, title: style == .cancel ? "取消" : "确定", action: action)
    }
    
    func setupView() {
        switch buttonStyle {
        case .cancel:
            backgroundColor = .white
            setTitleColor(UIColor(red: 113 / 255, green: 119 / 255, blue: 135 / 255, alpha: 1), for: .normal)
        case .confirm:
            setTitleColor(UIColor(red: 113 / 255, green: 119 / 255, blue: 135 / 255, alpha: 1), for: .normal)
            backgroundColor = UIColor(red: 255 / 255, green: 214 / 255, blue: 48 / 255, alpha: 1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}

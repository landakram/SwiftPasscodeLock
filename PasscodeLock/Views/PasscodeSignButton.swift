//
//  PasscodeSignButton.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import UIKit

@IBDesignable
public class PasscodeSignButton: UIButton {
    
    @IBInspectable
    public var passcodeSign: String = "1"
    
    @IBInspectable
    public var borderColor: UIColor = UIColor.whiteColor() {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable
    public var borderRadius: CGFloat = 30 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable
    public var highlightBackgroundColor: UIColor = UIColor.clearColor() {
        didSet {
            setupView()
        }
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupView()
        setupActions()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupActions()
    }
    
    public override func intrinsicContentSize() -> CGSize {
        
        return CGSizeMake(60, 60)
    }
    
    private var defaultBackgroundColor = UIColor.clearColor()
    
    private func setupView() {
        
        layer.borderWidth = 1
        layer.cornerRadius = borderRadius
        layer.borderColor = borderColor.CGColor
        
        self.titleLabel?.numberOfLines = 1
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.lineBreakMode = .ByClipping
        
        if let backgroundColor = backgroundColor {
            
            defaultBackgroundColor = backgroundColor
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.size.width / 2.0
        self.titleLabel?.font = self.titleLabel?.font.fontWithSize(self.frame.size.width / 2.2)
    }
    
    private func setupActions() {
        
        addTarget(self, action: Selector("handleTouchDown"), forControlEvents: .TouchDown)
        addTarget(self, action: Selector("handleTouchUp"), forControlEvents: [.TouchUpInside, .TouchDragOutside, .TouchCancel])
    }
    
    func handleTouchDown() {
        
        animateBackgroundColor(highlightBackgroundColor)
    }
    
    func handleTouchUp() {
        
        animateBackgroundColor(defaultBackgroundColor)
    }
    
    private func animateBackgroundColor(color: UIColor) {
        
        UIView.animateWithDuration(
            0.3,
            delay: 0.0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.0,
            options: [.AllowUserInteraction, .BeginFromCurrentState],
            animations: {
                
                self.backgroundColor = color
            },
            completion: nil
        )
    }
}

//
//  JZRollableLabel+Function.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/7.
//

// MARK: - JZRollableLabel Function
extension JZRollableLabel {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutUI()
        if isRolling {
            beginRolling()
        }
    }
    
    private func layoutUI() {
        mainLabel.frame = bounds
        rollingView.frame = bounds
        
        leadingLabel.sizeToFit()
        trailingLabel.sizeToFit()
        
        var layoutDirection: NSTextAlignment
        switch textAlignment {
        case .left, .right, .center:
            layoutDirection = textAlignment
        default:
            layoutDirection = UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .leftToRight ? .left : .right
        }
        if layoutDirection == .left {
            leadingLabel.center = CGPoint(x: leadingLabel.frame.width / 2, y: rollingView.center.y)
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: offset, dy: 0)
        } else if layoutDirection == .right {
            leadingLabel.center = CGPoint(x: bounds.maxX - leadingLabel.frame.width / 2, y: rollingView.center.y)
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: -offset, dy: 0)
        } else {
            if leadingLabel.frame.width > rollingView.frame.width {
                leadingLabel.center = CGPoint(x: leadingLabel.frame.width / 2, y: rollingView.center.y)
            } else {
                leadingLabel.center = rollingView.center
            }
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: offset, dy: 0)
        }
    }
    
    /// The function to begin rolling.
    /// Can be called before laying out the control,
    /// but the status might be changed multiple times, unexpectedly.
    @objc public func beginRolling() {
        initRolling()
        isRolling = true
        mainLabel.isHidden = true
        rollingView.isHidden = false
            NotificationCenter.default.addObserver(self, selector: #selector(beginRolling), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        switch style {
        case .rolling:
            let leadingAnimation = leadingRollingAnimation
            let trailingAnimation = trailingRollingAnimation
            trailingAnimation.delegate = self
            leadingLabel.layer.add(leadingAnimation, forKey: "JZRollableLabelAnimation")
            trailingLabel.layer.add(trailingAnimation, forKey: "JZRollableLabelAnimation")
        }
    }
    
    /// The function to terminate rolling.
    /// The status will not change to "stop" if the animation is already ended.
    public func stopRolling(immediately: Bool) {
        initRolling()
        if immediately {
            mainLabel.isHidden = false
            rollingView.isHidden = true
            leadingLabel.layer.removeAllAnimations()
            trailingLabel.layer.removeAllAnimations()
        }
    }
    
    /// The function to initiate rolling.
    internal func initRolling() {
        NotificationCenter.default.removeObserver(self)
        isRolling = false
        timer?.invalidate()
        timer = nil
    }
    
}

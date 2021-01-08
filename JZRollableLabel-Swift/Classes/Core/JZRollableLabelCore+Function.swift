//
//  JZRollableLabelCore+Function.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/8.
//

// MARK: - JZRollableLabel Function
extension JZRollableLabelCore {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutUI()
        if isRolling {
            beginRolling()
        }
    }
    
    private func layoutUI() {
        leadingLabel.sizeToFit()
        trailingLabel.sizeToFit()
        
        if alignment == .left {
            leadingLabel.center = CGPoint(x: leadingLabel.frame.width / 2, y: center.y)
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: offset, dy: 0)
        } else if alignment == .right {
            leadingLabel.center = CGPoint(x: bounds.maxX - leadingLabel.frame.width / 2, y: center.y)
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: -offset, dy: 0)
        } else {
            if leadingLabel.frame.width > frame.width {
                leadingLabel.center = CGPoint(x: leadingLabel.frame.width / 2, y: center.y)
            } else {
                leadingLabel.center = center
            }
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: offset, dy: 0)
        }
    }
    
    /// The function to begin rolling.
    /// Can be called before laying out the control,
    /// but the status might be changed multiple times, unexpectedly.
    @objc internal func beginRolling() {
        initRolling()
        isRolling = true
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
    internal func stopRolling(immediately: Bool) {
        initRolling()
        if immediately {
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

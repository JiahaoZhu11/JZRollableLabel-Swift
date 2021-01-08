//
//  JZRollableLabelCore+Animation.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/7.
//

// MARK: - JZRollableLabel Animation
extension JZRollableLabelCore {
    
    /// The getter that returns the leading rolling animation.
    internal var leadingRollingAnimation: CAAnimation {
        get {
            let distance = trailingLabel.center.x - leadingLabel.center.x
            let leadingAnimation = CABasicAnimation(keyPath: "position")
            leadingAnimation.fromValue = leadingLabel.center
            leadingAnimation.toValue = CGPoint(x: leadingLabel.center.x - distance, y: leadingLabel.center.y)
            leadingAnimation.duration = duration
            leadingAnimation.autoreverses = false
            leadingAnimation.fillMode = kCAFillModeRemoved
            leadingAnimation.repeatCount = 1
            if direction == .left {
                leadingAnimation.speed = distance > 0 ? speed : -speed
            } else {
                leadingAnimation.speed = distance > 0 ? -speed : speed
            }
            return leadingAnimation
        }
    }
    
    /// The getter that returns the trailing rolling animation.
    internal var trailingRollingAnimation: CAAnimation {
        get {
            let distance = trailingLabel.center.x - leadingLabel.center.x
            let trailingAnimation = CABasicAnimation(keyPath: "position")
            trailingAnimation.fromValue = trailingLabel.center
            trailingAnimation.toValue = CGPoint(x: trailingLabel.center.x - distance, y: trailingLabel.center.y)
            trailingAnimation.duration = duration
            trailingAnimation.autoreverses = false
            trailingAnimation.fillMode = kCAFillModeRemoved
            trailingAnimation.repeatCount = 1
            if direction == .left {
                trailingAnimation.speed = distance > 0 ? speed : -speed
            } else {
                trailingAnimation.speed = distance > 0 ? -speed : speed
            }
            return trailingAnimation
        }
    }
    
}

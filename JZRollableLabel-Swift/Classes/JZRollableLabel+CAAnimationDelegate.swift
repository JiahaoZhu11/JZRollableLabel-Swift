//
//  JZRollableLabel+CAAnimationDelegate.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/7.
//

// MARK: - CAAnimationDelegate
extension JZRollableLabel: CAAnimationDelegate {
    
    /// CAAnimationDelegate function, called while animation is began.
    public func animationDidStart(_ anim: CAAnimation) {
        // MARK: - Update Info
        _status = .began
    }
    
    /// CAAnimationDelegate function, called while animation is stopped.
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            // MARK: - Update Info
            _status = .ended
            // MARK: - Restart Animation
            if isRolling {
                timer = Timer.scheduledTimer(interval: gap, repeats: false) { [weak self] (timer) in
                    guard let weakSelf = self else { return }
                    if weakSelf.isRolling, weakSelf._status == .ended {
                        self?.beginRolling()
                    }
                    timer.invalidate()
                    weakSelf.timer = nil
                }
            } else {
                mainLabel.isHidden = false
                rollingView.isHidden = true
                leadingLabel.layer.removeAllAnimations()
                trailingLabel.layer.removeAllAnimations()
            }
        } else {
            // MARK: - Update Info
            if _status != .ended {
                _status = .stopped
            }
        }
    }
    
}

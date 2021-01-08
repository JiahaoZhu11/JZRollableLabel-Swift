//
//  JZRollableLabel+Function.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/7.
//

// MARK: - JZRollableLabel Function
extension JZRollableLabel {
    
    /// The function to begin rolling.
    /// Can be called before laying out the control,
    /// but the status might be changed multiple times, unexpectedly.
    public func beginRolling() {
        mainLabel.isHidden = true
        coreView.isHidden = false
        coreView.beginRolling()
    }
    
    /// The function to terminate rolling.
    /// The status will not change to "stop" if the animation is already ended.
    public func stopRolling(immediately: Bool) {
        coreView.stopRolling(immediately: immediately)
        if immediately {
            mainLabel.isHidden = false
            coreView.isHidden = true
        }
    }
    
}

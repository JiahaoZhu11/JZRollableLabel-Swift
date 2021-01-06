//
//  JZRollableLabelDelegate.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/7.
//

// MARK: - JZROllableLabelDelegate
@objc public protocol JZRollableLabelDelegate {
    
    /// The function called while the rolling animation did begin.
    @objc optional func rollingDidStart()
    
    /// The function called while the rolling animation did stop.
    /// The flag will be true if the animation gets to the end.
    @objc optional func rollingDidStop(finished flag: Bool)
    
}

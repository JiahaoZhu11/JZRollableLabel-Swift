//
//  JZRollableLabel+Enum.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/7.
//

// MARK: JZRollableLabel Enum
extension JZRollableLabel {
    
    /// These constants specify the direction of the rolling animation.
    public enum Direction: Int {
        
        /// Rolling from right to left.
        case left = 0
        
        /// Rolling from left to right.
        case right
        
        /// Rolling from trailing to leading.
        case leading
        
        /// Rolling from leading to trailing.
        case trailing
        
    }
    
    /// These constants specify the style of the rolling animation style.
    public enum Style: Int {
        
        /// Rolling towards one direction.
        case rolling = 0
        
//        /// Rolling backwards while the hiding end is displayed.
//        case bouncing
        
    }
    
    /// These constants specify the status of the rolling animation.
    public enum Status: Int {
        
        /// JZRollableLabel did initialized.
        case `init` = 0
        
        /// The rolling animation did begin.
        case began
        
        /// The rolling animation did end.
        case ended
        
        /// The rolling animation did stopped while the animation does not reach its end.
        case stopped
        
    }
    
}

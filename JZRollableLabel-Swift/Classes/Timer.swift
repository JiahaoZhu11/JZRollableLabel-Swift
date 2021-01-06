//
//  Timer.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/7.
//

// MARK: - Timer Generator
internal extension Timer {
    
    /// Creates a timer and schedules it on the current run loop in the default mode.
    /// Fits OS both above and below ios 10.0.
    class func scheduledTimer(interval: TimeInterval, repeats: Bool, block: @escaping ((_ timer: Timer) -> ())) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: interval,
                                        repeats: repeats,
                                        block: block)
        } else {
            return Timer.scheduledTimer(timeInterval: interval,
                                        target: self,
                                        selector: #selector(action(timer:)),
                                        userInfo: block,
                                        repeats: repeats)
        }
    }
    
    @objc private class func action(timer: Timer) {
        guard let block = timer.userInfo as? ((Timer) -> ()) else {
            return
        }
        block(timer);
    }
    
}

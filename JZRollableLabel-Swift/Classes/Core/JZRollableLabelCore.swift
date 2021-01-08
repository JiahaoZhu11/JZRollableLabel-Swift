//
//  JZRollableLabelCore.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2020/1/8.
//

// MARK: - JZRollableLabel
internal class JZRollableLabelCore: UIView {
    
    /// These constants specify the direction of the rolling animation.
    internal enum Direction: Int {
        
        /// Rolling from right to left.
        case left = 0
        
        /// Rolling from left to right.
        case right
        
    }
    
    /// These constants specify the direction of the rolling animation.
    internal enum Alignment: Int {
        
        /// Left aligned.
        case left = 0
        
        /// Right aligned.
        case right
        
        /// Centered.
        case center
        
    }
    
    /// The technique to use for aligning the labels.
    internal var alignment: Alignment = .left {
        didSet {
            layoutSubviews()
        }
    }
    
    // MARK: - Property
    /// The minimum spacing between the leading animating label and the trailing animating label.
    internal var spacing: CGFloat = 25 {
        didSet {
            layoutSubviews()
        }
    }
    
    /// The direction of the rolling animation, only allows 2 cases: left and right.
    internal var direction: Direction = .left {
        didSet {
            if isRolling {
                beginRolling()
            }
        }
    }
    
    /// The style of the animation.
    internal var style: JZRollableLabel.Style = .rolling {
        didSet {
            if isRolling {
                beginRolling()
            }
        }
    }
    
    /// The speed of the animation,
    /// default value is 1,
    /// representing 1 screen every 10 seconds.
    internal var speed: Float = 1 {
        didSet {
            if isRolling {
                beginRolling()
            }
        }
    }
    
    /// The duration of the animation with the speed of 1.
    internal var duration: CFTimeInterval {
        get {
            return CFTimeInterval(max(leadingLabel.frame.width / UIScreen.main.bounds.width, 1) * 10)
        }
    }
    
    /// The time gap between two rounds of animation.
    internal var gap: TimeInterval = 0
    
    /// The identifier if the label is rolling (or should be rolling).
    internal var isRolling: Bool = false
    
    /// The timer that repeats the animation.
    internal var timer: Timer?
    
    /// The object that acts as the delegate of the rolling label.
    internal var delegate: JZRollableLabelDelegate?
    
    /// The current status of the rolling animation.
    internal var status: JZRollableLabel.Status = .init {
        didSet {
            switch status {
            case .began:
                NSLog("Rolling Animation did begin")
                delegate?.rollingDidStart?()
            case .ended:
                NSLog("Rolling Animation did end")
                delegate?.rollingDidStop?(finished: true)
            case .stopped:
                NSLog("Rolling Animation did stop")
                delegate?.rollingDidStop?(finished: false)
            default:
                break
            }
        }
    }
    
    // MARK: - JZRollableLabel Property
    /// The leading animating label.
    internal lazy var leadingLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        return label
    }()
    
    /// The trailing animating label.
    internal lazy var trailingLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        return label
    }()
    
    // MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Simulating UILabel which the user interaction is disabled by default.
        layer.masksToBounds = true
        
        // Initializing visual direction according to the layout direction.
        if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight {
            direction = .left
            alignment = .left
        } else {
            direction = .right
            alignment = .right
        }
        
        // Setting up UI
        addSubview(leadingLabel)
        addSubview(trailingLabel)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    deinit {
        initRolling()
    }
    
}

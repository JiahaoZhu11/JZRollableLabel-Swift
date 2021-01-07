//
//  JZRollableLabel.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2020/12/31.
//

// MARK: - JZRollableLabel
open class JZRollableLabel: UIView {
    
    // MARK: - Property
    /// The minimum spacing between the leading animating label and the trailing animating label.
    public var spacing: CGFloat = 25 {
        didSet {
            layoutSubviews()
        }
    }
    
    /// The direction of the rolling animation.
    public var direction: Direction = .leading {
        didSet {
            if direction == .leading {
                if UIView.userInterfaceLayoutDirection(for: rollingView.semanticContentAttribute) == .leftToRight {
                    visualDirection = .left
                } else {
                    visualDirection = .right
                }
            } else if direction == .trailing {
                if UIView.userInterfaceLayoutDirection(for: rollingView.semanticContentAttribute) == .leftToRight {
                    visualDirection = .right
                } else {
                    visualDirection = .left
                }
            } else {
                visualDirection = direction
            }
        }
    }
    
    /// The visual direction of the rolling animation, only allows 2 cases: left and right.
    internal var visualDirection: Direction = .left {
        didSet {
            if isRolling {
                beginRolling()
            }
        }
    }
    
    /// The style of the animation.
    public var style: Style = .rolling {
        didSet {
            if isRolling {
                beginRolling()
            }
        }
    }
    
    /// The speed of the animation,
    /// default value is 1,
    /// representing 1 screen every 10 seconds.
    public var speed: Float = 1 {
        didSet {
            if isRolling {
                beginRolling()
            }
        }
    }
    
    /// The duration of the animation.
    public var duration: TimeInterval {
        get {
            return _duration / TimeInterval(speed)
        }
    }
    
    /// The duration of the animation with the speed of 1.
    internal var _duration: CFTimeInterval {
        get {
            return CFTimeInterval(max(leadingLabel.frame.width / UIScreen.main.bounds.width, 1) * 10)
        }
    }
    
    /// The time gap between two rounds of animation.
    public var gap: TimeInterval = 0
    
    /// The identifier if the label is rolling (or should be rolling).
    internal var isRolling: Bool = false
    
    /// The timer that repeats the animation.
    internal var timer: Timer?
    
    /// The object that acts as the delegate of the rolling label.
    public var delegate: JZRollableLabelDelegate?
    
    /// The current status of the rolling animation, read-only.
    public var status: Status {
        get {
            return _status
        }
    }
    
    /// The internal variable of the current status of the rolling animation.
    internal var _status: Status = .`init` {
        didSet {
            switch _status {
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
    /// The label that simulates UILabel which is displayed when the annimation is stopped.
    internal lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        return label
    }()
    
    /// The view the contains the animating labels.
    internal lazy var rollingView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()
    
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
        isUserInteractionEnabled = false
        
        // Enabling all lineBreakMode values, considering support numberOfLines property in the future.
        mainLabel.numberOfLines = 0
        
        // Initializing visual direction according to the layout direction.
        if UIView.userInterfaceLayoutDirection(for: rollingView.semanticContentAttribute) == .leftToRight {
            visualDirection = .left
        } else {
            visualDirection = .right
        }
        
        // Setting up UI
        addSubview(mainLabel)
        addSubview(rollingView)
        rollingView.addSubview(leadingLabel)
        rollingView.addSubview(trailingLabel)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    deinit {
        initRolling()
    }
    
}

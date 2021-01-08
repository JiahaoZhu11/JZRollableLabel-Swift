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
    public var spacing: CGFloat {
        set {
            coreView.spacing = newValue
        }
        get {
            return coreView.spacing
        }
    }
    
    /// The direction of the rolling animation.
    public var direction: Direction = .leading {
        didSet {
            switch direction {
            case .leading:
                if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight {
                    coreView.direction = .left
                } else {
                    coreView.direction = .right
                }
            case .trailing:
                if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight {
                    coreView.direction = .right
                } else {
                    coreView.direction = .left
                }
            case .left:
                coreView.direction = .left
            case .right:
                coreView.direction = .right
            }
        }
    }
    
    /// The style of the animation.
    public var style: Style {
        set {
            coreView.style = newValue
        }
        get {
            return coreView.style
        }
    }
    
    /// The speed of the animation,
    /// default value is 1,
    /// representing 1 screen every 10 seconds.
    public var speed: Float {
        set {
            coreView.speed = newValue
        }
        get {
            return coreView.speed
        }
    }
    
    /// The duration of the animation.
    public var duration: TimeInterval {
        get {
            return coreView.duration / TimeInterval(speed)
        }
    }
    
    /// The time gap between two rounds of animation.
    public var gap: TimeInterval {
        set {
            coreView.gap = newValue
        }
        get {
            return coreView.gap
        }
    }
    
    /// The object that acts as the delegate of the rolling label.
    public var delegate: JZRollableLabelDelegate? {
        set {
            coreView.delegate = newValue
        }
        get {
            return coreView.delegate
        }
    }
    
    /// The current status of the rolling animation, read-only.
    public var status: Status {
        get {
            return coreView.status
        }
    }
    
    // MARK: - JZRollableLabel Property
    /// The label that simulates UILabel which is displayed when the annimation is stopped.
    internal lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// The view the contains the animating labels.
    internal lazy var coreView: JZRollableLabelCore = {
        let view = JZRollableLabelCore()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Simulating UILabel which the user interaction is disabled by default.
        isUserInteractionEnabled = false
        
        // Setting up UI
        addSubview(mainLabel)
        mainLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(coreView)
        coreView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        coreView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        coreView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        coreView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

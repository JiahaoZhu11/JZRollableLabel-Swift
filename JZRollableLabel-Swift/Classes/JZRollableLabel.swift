//
//  JZRollableLabel.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2020/12/31.
//

// MARK: - JZROllableLabelDelegate
@objc public protocol JZRollableLabelDelegate {
    
    /// The function called while the rolling animation did begin.
    @objc optional func rollingDidStart()
    
    /// The function called while the rolling animation did stop.
    /// The flag will be true if the animation gets to the end.
    @objc optional func rollingDidStop(finished flag: Bool)
    
}

// MARK: - JZRollableLabel
open class JZRollableLabel: UIView {
    
    // MARK: RollableLabel Enum
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
        case `init`
        
        /// The rolling animation did begin.
        case began
        
        /// The rolling animation did end.
        case ended
        
        /// The rolling animation did stopped while the animation does not reach its end.
        case stopped
        
    }
    
    // MARK: - RollableLabel Property
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
    private var visualDirection: Direction = .left {
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
    private var _duration: CFTimeInterval {
        get {
            return CFTimeInterval(max(leadingLabel.frame.width / UIScreen.main.bounds.width, 1) * 10)
        }
    }
    
    /// The time gap between two rounds of animation.
    public var gap: TimeInterval = 0
    
    /// The identifier if the label is rolling (or should be rolling).
    private var isRolling: Bool = false
    
    /// The timer that repeats the animation.
    private var timer: Timer?
    
    /// The object that acts as the delegate of the rolling label.
    public var delegate: JZRollableLabelDelegate?
    
    /// The current status of the rolling animation, read-only.
    public var status: Status {
        get {
            return _status
        }
    }
    
    /// The private variable of the current status of the rolling animation.
    private var _status: Status = .init {
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
    
    // MARK: - UILabel Property
    /// The text that the label is displaying.
    public var text: String? { // default is nil
        set {
            mainLabel.text = newValue
            leadingLabel.text = newValue
            trailingLabel.text = newValue
            layoutSubviews()
        }
        get {
            return mainLabel.text
        }
    }
    
    /// The font used to display the text.
    public var font: UIFont! { // default is nil (system font 17 plain)
        set {
            mainLabel.font = newValue
            leadingLabel.font = newValue
            trailingLabel.font = newValue
            layoutSubviews()
        }
        get {
            return mainLabel.font
        }
    }
    
    /// The color of the text.
    public var textColor: UIColor! { // default is labelColor
        set {
            mainLabel.textColor = newValue
            leadingLabel.textColor = newValue
            trailingLabel.textColor = newValue
            layoutSubviews()
        }
        get {
            return mainLabel.textColor
        }
    }
    
    /// The shadow color of the text.
    public var shadowColor: UIColor? { // default is nil (no shadow)
        set {
            mainLabel.shadowColor = newValue
            leadingLabel.shadowColor = newValue
            trailingLabel.shadowColor = newValue
            layoutSubviews()
        }
        get {
            return mainLabel.shadowColor
        }
    }
    
    /// The shadow offset (measured in points) for the text.
    public var shadowOffset: CGSize { // default is CGSizeMake(0, -1) -- a top shadow
        set {
            mainLabel.shadowOffset = newValue
            leadingLabel.shadowOffset = newValue
            trailingLabel.shadowOffset = newValue
            layoutSubviews()
        }
        get {
            return mainLabel.shadowOffset
        }
    }
    
    /// The technique to use for aligning the text.
    public var textAlignment: NSTextAlignment { // default is NSTextAlignmentNatural (before iOS 9, the default was NSTextAlignmentLeft)
        set {
            mainLabel.textAlignment = newValue
            layoutSubviews()
        }
        get {
            return mainLabel.textAlignment
        }
    }
    
    /// The technique for wrapping and truncating the label’s text.
    public var lineBreakMode: NSLineBreakMode { // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text
        set {
            mainLabel.lineBreakMode = newValue
            layoutSubviews()
        }
        get {
            return mainLabel.lineBreakMode
        }
    }
    
    /// The styled text that the label displays.
    public var attributedText: NSAttributedString? { // default is nil
        set {
            mainLabel.attributedText = newValue
            leadingLabel.attributedText = newValue
            trailingLabel.attributedText = newValue
            layoutSubviews()
        }
        get {
            return mainLabel.attributedText
        }
    }
    
    /// The highlight color for the label’s text.
    public var highlightedTextColor: UIColor? { // default is nil
        set {
            mainLabel.highlightedTextColor = newValue
            leadingLabel.highlightedTextColor = newValue
            trailingLabel.highlightedTextColor = newValue
        }
        get {
            return mainLabel.highlightedTextColor
        }
    }
    
    /// A Boolean value that determines whether the label draws its text with a highlight.
    public var isHighlighted: Bool { // default is NO
        set {
            mainLabel.isHighlighted = newValue
            leadingLabel.isHighlighted = newValue
            trailingLabel.isHighlighted = newValue
        }
        get {
            return mainLabel.isHighlighted
        }
    }
    
    /// A Boolean value that determines whether the label draws its text in an enabled state.
    public var isEnabled: Bool { // default is YES. changes how the label is drawn
        set {
            mainLabel.isEnabled = newValue
            leadingLabel.isEnabled = newValue
            trailingLabel.isEnabled = newValue
        }
        get {
            return mainLabel.isEnabled
        }
    }
    
    // MARK: - Not Yet Supported
//    // this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single line). A value of 0 means no limit
//    // if the height of the text reaches the # of lines or the height of the view is less than the # of lines allowed, the text will be
//    // truncated using the line break mode.
//
//    /// The maximum number of lines for rendering text.
//    public var numberOfLines: Int {
//        set {
//            mainLabel.numberOfLines = newValue
//            layoutSubviews()
//        }
//        get {
//            return mainLabel.numberOfLines
//        }
//    }
//
//    // these next 3 properties allow the label to be autosized to fit a certain width by scaling the font size(s) by a scaling factor >= the minimum scaling factor
//    // and to specify how the text baseline moves when it needs to shrink the font.
//
//    /// A Boolean value that determines whether the label reduces the text’s font size to fit the title string into the label’s bounding rectangle.
//    public var adjustsFontSizeToFitWidth: Bool { // default is NO
//        set {
//            mainLabel.adjustsFontSizeToFitWidth = newValue
//        }
//        get {
//            return mainLabel.adjustsFontSizeToFitWidth
//        }
//    }
//
//    /// An option that controls whether the text's baseline remains fixed when text needs to shrink to fit in the label.
//    public var baselineAdjustment: UIBaselineAdjustment { // default is UIBaselineAdjustmentAlignBaselines
//        set {
//            mainLabel.baselineAdjustment = newValue
//        }
//        get {
//            return mainLabel.baselineAdjustment
//        }
//    }
//
//    /// The minimum scale factor for the label’s text.
//    public var minimumScaleFactor: CGFloat { // default is 0.0
//        set {
//            mainLabel.minimumScaleFactor = newValue
//        }
//        get {
//            return mainLabel.minimumScaleFactor
//        }
//    }
//
//    // Tightens inter-character spacing in attempt to fit lines wider than the available space if the line break mode is one of the truncation modes before starting to truncate.
//    // The maximum amount of tightening performed is determined by the system based on contexts such as font, line width, etc.
//
//    /// A Boolean value that determines whether the label tightens text before truncating.
//    public var allowsDefaultTighteningForTruncation: Bool { // default is NO
//        set {
//            mainLabel.allowsDefaultTighteningForTruncation = newValue
//        }
//        get {
//            return mainLabel.allowsDefaultTighteningForTruncation
//        }
//    }
//
//    // Specifies the line break strategies that may be used for laying out the text in this label.
//    // If this property is not set, the default value is NSLineBreakStrategyStandard.
//    // If the label contains an attributed text with paragraph style(s) that specify a set of line break strategies, the set of strategies in the paragraph style(s) will be used instead of the set of strategies defined by this property.
//    public var lineBreakStrategy: NSParagraphStyle.LineBreakStrategy {
//        set {
//            mainLabel.lineBreakStrategy = newValue
//        }
//        get {
//            return mainLabel.lineBreakStrategy
//        }
//    }
//
//    // Support for constraint-based layout (auto layout)
//    // If nonzero, this is used when determining -intrinsicContentSize for multiline labels
//
//    /// The preferred maximum width, in points, for a multiline label.
//    public var preferredMaxLayoutWidth: CGFloat {
//        set {
//            mainLabel.preferredMaxLayoutWidth = newValue
//        }
//        get {
//            return mainLabel.preferredMaxLayoutWidth
//        }
//    }
    
    /// The label that simulates UILabel which is displayed when the annimation is stopped.
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        return label
    }()
    
    /// The view the contains the animating labels.
    private lazy var rollingView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()
    
    /// The leading animating label.
    private lazy var leadingLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        return label
    }()
    
    /// The trailing animating label.
    private lazy var trailingLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        return label
    }()
    
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
        
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        initRolling()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutUI()
        if isRolling {
            beginRolling()
        }
    }
    
    private func setupUI() {
        addSubview(mainLabel)
        addSubview(rollingView)
        rollingView.addSubview(leadingLabel)
        rollingView.addSubview(trailingLabel)
    }
    
    private func layoutUI() {
        mainLabel.frame = bounds
        rollingView.frame = bounds
        
        leadingLabel.sizeToFit()
        trailingLabel.sizeToFit()
        
        var layoutDirection: NSTextAlignment
        switch textAlignment {
        case .left, .right, .center:
            layoutDirection = textAlignment
        default:
            layoutDirection = UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .leftToRight ? .left : .right
        }
        if layoutDirection == .left {
            leadingLabel.center = CGPoint(x: leadingLabel.frame.width / 2, y: rollingView.center.y)
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: offset, dy: 0)
        } else if layoutDirection == .right {
            leadingLabel.center = CGPoint(x: bounds.maxX - leadingLabel.frame.width / 2, y: rollingView.center.y)
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: -offset, dy: 0)
        } else {
            if leadingLabel.frame.width > rollingView.frame.width {
                leadingLabel.center = CGPoint(x: leadingLabel.frame.width / 2, y: rollingView.center.y)
            } else {
                leadingLabel.center = rollingView.center
            }
            let offset = max(frame.width, leadingLabel.frame.width + spacing)
            trailingLabel.frame = leadingLabel.frame.offsetBy(dx: offset, dy: 0)
        }
    }
}

// MARK: - RollableLabel Function
extension JZRollableLabel {
    
    /// The function to begin rolling.
    /// Can be called before laying out the control,
    /// but the status might be changed multiple times, unexpectedly.
    @objc public func beginRolling() {
        initRolling()
        isRolling = true
        mainLabel.isHidden = true
        rollingView.isHidden = false
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
    public func stopRolling(immediately: Bool) {
        initRolling()
        if immediately {
            mainLabel.isHidden = false
            rollingView.isHidden = true
            leadingLabel.layer.removeAllAnimations()
            trailingLabel.layer.removeAllAnimations()
        }
    }
    
    /// The function to initiate rolling.
    private func initRolling() {
        NotificationCenter.default.removeObserver(self)
        isRolling = false
        timer?.invalidate()
        timer = nil
    }
    
}

// MARK: - UILabel Function
extension JZRollableLabel {
    
    /// The natural size for the receiving view, considering only properties of the view itself.
    public override var intrinsicContentSize: CGSize {
        get {
            mainLabel.sizeToFit()
            return mainLabel.frame.size
        }
    }
    
    /// Resizes and moves the receiver’s content view so it just encloses its subviews.
    public override func sizeToFit() {
        mainLabel.sizeToFit()
        frame.size = mainLabel.frame.size
        rollingView.frame.size = mainLabel.frame.size
    }
    
    // MARK: - Not Yet Supported
//    // override points. can adjust rect before calling super.
//    // label has default content mode of UIViewContentModeRedraw
//
//    open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//
//    }
//
//    open func drawText(in rect: CGRect) {
//
//    }

}

// MARK: - RollableLabel Animation
extension JZRollableLabel {
    
    /// The getter that returns the leading rolling animation.
    private var leadingRollingAnimation: CAAnimation {
        get {
            let distance = trailingLabel.center.x - leadingLabel.center.x
            let leadingAnimation = CABasicAnimation(keyPath: "position")
            leadingAnimation.fromValue = leadingLabel.center
            leadingAnimation.toValue = CGPoint(x: leadingLabel.center.x - distance, y: leadingLabel.center.y)
            leadingAnimation.duration = _duration
            leadingAnimation.autoreverses = false
            leadingAnimation.fillMode = kCAFillModeRemoved
            leadingAnimation.repeatCount = 1
            if visualDirection == .left {
                leadingAnimation.speed = distance > 0 ? speed : -speed
            } else {
                leadingAnimation.speed = distance > 0 ? -speed : speed
            }
            return leadingAnimation
        }
    }
    
    /// The getter that returns the trailing rolling animation.
    private var trailingRollingAnimation: CAAnimation {
        get {
            let distance = trailingLabel.center.x - leadingLabel.center.x
            let trailingAnimation = CABasicAnimation(keyPath: "position")
            trailingAnimation.fromValue = trailingLabel.center
            trailingAnimation.toValue = CGPoint(x: trailingLabel.center.x - distance, y: trailingLabel.center.y)
            trailingAnimation.duration = _duration
            trailingAnimation.autoreverses = false
            trailingAnimation.fillMode = kCAFillModeRemoved
            trailingAnimation.repeatCount = 1
            if visualDirection == .left {
                trailingAnimation.speed = distance > 0 ? speed : -speed
            } else {
                trailingAnimation.speed = distance > 0 ? -speed : speed
            }
            return trailingAnimation
        }
    }
    
}

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

// MARK: - Timer Easy Generator
fileprivate extension Timer {
    
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

//
//  JZRollableLabel+UILabelFeature.swift
//  JZRollableLabel-Swift
//
//  Created by Jiahao Zhu on 2021/1/7.
//

// MARK: - UILabel Property
extension JZRollableLabel {
    
    /// The natural size for the receiving view, considering only properties of the view itself.
    public override var intrinsicContentSize: CGSize {
        get {
            return mainLabel.intrinsicContentSize
        }
    }
    
    /// The text that the label is displaying.
    public var text: String? { // default is nil
        set {
            mainLabel.text = newValue
            coreView.text = newValue
        }
        get {
            return mainLabel.text
        }
    }
    
    /// The font used to display the text.
    public var font: UIFont! { // default is nil (system font 17 plain)
        set {
            mainLabel.font = newValue
            coreView.font = newValue
        }
        get {
            return mainLabel.font
        }
    }
    
    /// The color of the text.
    public var textColor: UIColor! { // default is labelColor
        set {
            mainLabel.textColor = newValue
            coreView.textColor = newValue
        }
        get {
            return mainLabel.textColor
        }
    }
    
    /// The shadow color of the text.
    public var shadowColor: UIColor? { // default is nil (no shadow)
        set {
            mainLabel.shadowColor = newValue
            coreView.shadowColor = newValue
        }
        get {
            return mainLabel.shadowColor
        }
    }
    
    /// The shadow offset (measured in points) for the text.
    public var shadowOffset: CGSize { // default is CGSizeMake(0, -1) -- a top shadow
        set {
            mainLabel.shadowOffset = newValue
            coreView.shadowOffset = newValue
        }
        get {
            return mainLabel.shadowOffset
        }
    }
    
    /// The technique to use for aligning the text.
    public var textAlignment: NSTextAlignment { // default is NSTextAlignmentNatural (before iOS 9, the default was NSTextAlignmentLeft)
        set {
            mainLabel.textAlignment = newValue
            switch newValue {
            case .left:
                coreView.alignment = .left
            case .right:
                coreView.alignment = .right
            case .center:
                coreView.alignment = .center
            default:
                coreView.alignment = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight ? .left : .right
            }
        }
        get {
            return mainLabel.textAlignment
        }
    }
    
    /// The technique for wrapping and truncating the label’s text.
    public var lineBreakMode: NSLineBreakMode { // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text
        set {
            mainLabel.lineBreakMode = newValue
            coreView.layoutSubviews()
        }
        get {
            return mainLabel.lineBreakMode
        }
    }
    
    /// The styled text that the label displays.
    public var attributedText: NSAttributedString? { // default is nil
        set {
            mainLabel.attributedText = newValue
            coreView.attributedText = newValue
        }
        get {
            return mainLabel.attributedText
        }
    }
    
    /// The highlight color for the label’s text.
    public var highlightedTextColor: UIColor? { // default is nil
        set {
            mainLabel.highlightedTextColor = newValue
            coreView.highlightedTextColor = newValue
        }
        get {
            return mainLabel.highlightedTextColor
        }
    }
    
    /// A Boolean value that determines whether the label draws its text with a highlight.
    public var isHighlighted: Bool { // default is NO
        set {
            mainLabel.isHighlighted = newValue
            coreView.isHighlighted = newValue
        }
        get {
            return mainLabel.isHighlighted
        }
    }
    
    /// A Boolean value that determines whether the label draws its text in an enabled state.
    public var isEnabled: Bool { // default is YES. changes how the label is drawn
        set {
            mainLabel.isEnabled = newValue
            coreView.isEnabled = newValue
        }
        get {
            return mainLabel.isEnabled
        }
    }
    
    // this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single line). A value of 0 means no limit
    // if the height of the text reaches the # of lines or the height of the view is less than the # of lines allowed, the text will be
    // truncated using the line break mode.

    /// The maximum number of lines for rendering text.
    public var numberOfLines: Int {
        set {
            mainLabel.numberOfLines = newValue
            coreView.layoutSubviews()
        }
        get {
            return mainLabel.numberOfLines
        }
    }
    
    // MARK: - Not Yet Supported
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

}

// MARK: - UILabel Function
extension JZRollableLabel {
    
    /// Resizes and moves the receiver’s content view so it just encloses its subviews.
    public override func sizeToFit() {
        let center = self.center
        let frame = self.frame
        switch coreView.alignment {
        case .left:
            self.frame = CGRect(x: frame.origin.x, y: center.y - intrinsicContentSize.height / 2, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
        case .right:
            self.frame = CGRect(x: frame.maxX - intrinsicContentSize.width, y: center.y - intrinsicContentSize.height / 2, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
        case .center:
            self.frame.size = intrinsicContentSize
            self.center = center
        }
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

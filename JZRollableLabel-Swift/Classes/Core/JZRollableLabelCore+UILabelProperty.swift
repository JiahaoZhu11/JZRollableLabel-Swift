//
//  JZRollableLabelCore+UILabelProperty.swift
//  JZRollableLabel-Swift
//
//  Created by Banma on 2021/1/8.
//

// MARK: - UILabel Property
extension JZRollableLabelCore {
    
    /// The text that the label is displaying.
    public var text: String? { // default is nil
        set {
            leadingLabel.text = newValue
            trailingLabel.text = newValue
            layoutSubviews()
        }
        get {
            return leadingLabel.text
        }
    }
    
    /// The font used to display the text.
    public var font: UIFont! { // default is nil (system font 17 plain)
        set {
            leadingLabel.font = newValue
            trailingLabel.font = newValue
            layoutSubviews()
        }
        get {
            return leadingLabel.font
        }
    }
    
    /// The color of the text.
    public var textColor: UIColor! { // default is labelColor
        set {
            leadingLabel.textColor = newValue
            trailingLabel.textColor = newValue
        }
        get {
            return leadingLabel.textColor
        }
    }
    
    /// The shadow color of the text.
    public var shadowColor: UIColor? { // default is nil (no shadow)
        set {
            leadingLabel.shadowColor = newValue
            trailingLabel.shadowColor = newValue
        }
        get {
            return leadingLabel.shadowColor
        }
    }
    
    /// The shadow offset (measured in points) for the text.
    public var shadowOffset: CGSize { // default is CGSizeMake(0, -1) -- a top shadow
        set {
            leadingLabel.shadowOffset = newValue
            trailingLabel.shadowOffset = newValue
        }
        get {
            return leadingLabel.shadowOffset
        }
    }
    
    /// The styled text that the label displays.
    public var attributedText: NSAttributedString? { // default is nil
        set {
            leadingLabel.attributedText = newValue
            trailingLabel.attributedText = newValue
            layoutSubviews()
        }
        get {
            return leadingLabel.attributedText
        }
    }
    
    /// The highlight color for the label’s text.
    public var highlightedTextColor: UIColor? { // default is nil
        set {
            leadingLabel.highlightedTextColor = newValue
            trailingLabel.highlightedTextColor = newValue
        }
        get {
            return leadingLabel.highlightedTextColor
        }
    }
    
    /// A Boolean value that determines whether the label draws its text with a highlight.
    public var isHighlighted: Bool { // default is NO
        set {
            leadingLabel.isHighlighted = newValue
            trailingLabel.isHighlighted = newValue
        }
        get {
            return leadingLabel.isHighlighted
        }
    }
    
    /// A Boolean value that determines whether the label draws its text in an enabled state.
    public var isEnabled: Bool { // default is YES. changes how the label is drawn
        set {
            leadingLabel.isEnabled = newValue
            trailingLabel.isEnabled = newValue
        }
        get {
            return leadingLabel.isEnabled
        }
    }

}

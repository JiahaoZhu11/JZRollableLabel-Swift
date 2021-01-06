# JZRollableLabel

[![CI Status](https://img.shields.io/travis/jiahao_zhu98@outlook.com/JZRollableLabel.svg?style=flat)](https://travis-ci.org/jiahao_zhu98@outlook.com/JZRollableLabel)
[![Version](https://img.shields.io/cocoapods/v/JZRollableLabel.svg?style=flat)](https://cocoapods.org/pods/JZRollableLabel)
[![License](https://img.shields.io/cocoapods/l/JZRollableLabel.svg?style=flat)](https://cocoapods.org/pods/JZRollableLabel)
[![Platform](https://img.shields.io/cocoapods/p/JZRollableLabel.svg?style=flat)](https://cocoapods.org/pods/JZRollableLabel)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Minimum iOS Target: 9.0.

## Installation

JZRollableLabel is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'JZRollableLabel'
```

## Usage

JZRollableLabel can be easily created and used with the following code:

```swift
let label = JZRollableLabel(/*frame: <any CGRect>*/)
view.addSubview(label)
/* Any additional operations to layout the label.
	 The layout feature of this label is designed to the same as UILabel. */
```

The rolling animation can be started by calling the function 'beginRolling()':

```swift
label.beginRolling()
/* This function can be called anytime,
	 but calling it too early will case unexpected changes of its status due to layouting. */
```

The rolling animation can be stopped by calling the function 'stopRolling(immediately: Bool)':

```swift
/* Passing different values will cause the different in wyas to terminate the animation. */

label.stopRolling(immediately: true)
/* This will stop the animation immediately. */

label.stopRolling(immediately: true)
/* This will stop the animation after the current round of animation completes. */
```

Properties if JZRollableLabel is mutable anytime but changing them will restart the animation the beginning, so if you want to change it more smoothly, or after the current round if animation, the delegate can be used and the function 'rollingDidStop(finished flag: Bool)' is what you are looking for. It can be used in the following ways:

```swift
extension /* The class of any object you want to use as the delegate */: JZRollableLabelDelegate {
    
  	/* This is called when the animation has stopped. */
    func rollingDidStop(finished flag: Bool) {
        if flag {
						/* This is the situation while the animation goes to the end. */
        } else {
						/* This is the situation while the animation being interrupted by any other operation. */
        }
    }
    
  	/* This is called when the animation has began. */
    func rollingDidStart() {
      	
    }
    
}
```

## Property and Function

The properties unique to JZRollableLabel are listed below:

| Property  | Access Right | Description                                                  |
| --------- | ------------ | ------------------------------------------------------------ |
| spacing   | Readwrite    | The minimum spacing between the leading animating label and the trailing animating label. |
| direction | Readwrite    | The direction of the rolling animation.                      |
| style     | Readwrite    | The style of the animation.                                  |
| speed     | Readwrite    | The speed of the animation, default value is 1, representing 1 screen every 10 seconds. |
| duration  | Read-only    | The duration of the animation.                               |
| gap       | Readwrite    | The time gap between two rounds of animation.                |
| delegate  | Readwrite    | The object that acts as the delegate of the rolling label.   |
| status    | Read-only    | The current status of the rolling animation, read-only.      |

The supported UILabel properties are listed below:

| Property             | Access Right | Description                                                  |
| -------------------- | ------------ | ------------------------------------------------------------ |
| text                 | Readwrite    | The text that the label is displaying.                       |
| font                 | Readwrite    | The font used to display the text.                           |
| textColor            | Readwrite    | The color of the text.                                       |
| shadowColor          | Readwrite    | The shadow color of the text.                                |
| shadowOffset         | Readwrite    | The shadow offset (measured in points) for the text.         |
| textAlignment        | Readwrite    | The technique to use for aligning the text.                  |
| lineBreakMode        | Readwrite    | The technique for wrapping and truncating the label's text.  |
| attributedText       | Readwrite    | The styled text that the label displays.                     |
| highlightedTextColor | Readwrite    | The highlight color for the label’s text.                    |
| isHighlighted        | Readwrite    | A Boolean value that determines whether the label draws its text with a highlight. |
| isEnabled            | Readwrite    | A Boolean value that determines whether the label draws its text in an enabled state. |

The special functions implemented for JZRollableLabel are listed below:

| Function                                                     | Description                                                  | Note                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| beginRolling()                                               | The function to begin rolling.                               | Can be called before laying out the control, but the status might be changed multiple times, unexpectedly. |
| stopRolling(immediately: Bool)                               | The function to terminate rolling.                           | The status will not change to "stop" if the animation is already ended. |
| animationDidStart(**_** anim: CAAnimation)                   | CAAnimationDelegate function, called while animation is began. | Remember to call 'super.animationDidStart(**_** anim: CAAnimation)' while subclassing JZRollableLabel, otherwise the rolling functions and properties might not work properly. |
| animationDidStop(**_** anim: CAAnimation, finished flag: Bool) | CAAnimationDelegate function, called while animation is stopped. | Remember to call 'super.animationDidStop(**_** anim: CAAnimation, finished flag: Bool)' while subclassing JZRollableLabel, otherwise the rolling functions and properties might not work properly. |

## Author

朱嘉皓, jiahao_zhu98@outlook.com

## License

JZRollableLabel is available under the MIT license. See the LICENSE file for more info.

/// A Figma easing type.
///
/// "Enum describing animation easing curves."
/// https://www.figma.com/developers/api#easingtype-type
public enum EasingType: String, Codable {
  /// Ease in with an animation curve similar to CSS ease-in.
  case easeIn = "EASE_IN"
  /// Ease out with an animation curve similar to CSS ease-out.
  case easeOut = "EASE_OUT"
  /// Ease in and then out with an animation curve similar to CSS ease-in-out.
  case easeInAndOut = "EASE_IN_AND_OUT"
  /// No easing, similar to CSS linear.
  case linear = "LINEAR"
}


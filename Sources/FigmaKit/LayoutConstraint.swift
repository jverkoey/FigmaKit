/// A Figma layout constraint.
///
/// "Layout constraint relative to containing Frame."
/// https://www.figma.com/developers/api#layoutconstraint-type
public struct LayoutConstraint: Codable {
  /// The type of constraint to apply.
  public let vertical: Vertical
  /// See `ConstraintType` for effect of this field.
  public let horizontal: Horizontal

  public enum Vertical: String, Codable {
    /// Node is laid out relative to top of the containing frame.
    case top = "TOP"
    /// Node is laid out relative to bottom of the containing frame.
    case bottom = "BOTTOM"
    /// Node is vertically centered relative to containing frame.
    case center = "CENTER"
    /// Both top and bottom of node are constrained relative to containing frame (node stretches with frame).
    case topBottom = "TOP_BOTTOM"
    /// Node scales vertically with containing frame.
    case scale = "SCALE"
  }

  public enum Horizontal: String, Codable {
    /// Node is laid out relative to left of the containing frame.
    case left = "LEFT"
    /// Node is laid out relative to right of the containing frame
    case right = "RIGHT"
    /// Node is horizontally centered relative to containing frame.
    case center = "CENTER"
    /// Both left and right of node are constrained relative to containing frame (node stretches with frame).
    case leftRight = "LEFT_RIGHT"
    /// Node scales horizontally with containing frame
    case scale = "SCALE"
  }
}


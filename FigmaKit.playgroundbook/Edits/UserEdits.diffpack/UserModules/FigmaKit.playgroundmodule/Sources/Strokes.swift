/// A Figma stroke cap.
///
/// "Describes the end caps of vector paths."
public enum StrokeCap: String, Codable {
    case none = "NONE"
    case round = "ROUND"
    case square = "SQUARE"
    case lineArrow = "LINE_ARROW"
    case triangleArrow = "TRIANGLE_ARROW"
}

/// A Figma stroke join.
///
/// "Describes how corners in vector paths are rendered."
public enum StrokeJoin: String, Codable {
    case miter = "MITER"
    case bevel = "BEVEL"
    case round = "ROUND"
}

/// A Figma stroke align.
///
/// "Position of stroke relative to vector outline."
public enum StrokeAlign: String, Codable {
    /// Stroke drawn inside the shape boundary.
    case inside = "INSIDE"
    /// Stroke drawn outside the shape boundary.
    case outside = "OUTSIDE"
    /// Stroke drawn along the shape boundary.
    case center = "CENTER"
}

/// A Figma path.
///
/// "A series of path commands that encodes how to draw the path."
/// https://www.figma.com/plugin-docs/api/properties/VectorPath-data/
public struct Path: Codable {
    /// A series of path commands that encodes how to draw the path.
    ///
    /// Figma supports a subset of the SVG path format. Path commands must be
    /// joined into a single string in order separated by a single space.
    ///
    /// Supported commands:
    /// - `M x y`: The absolute "move to" command.
    /// - `L x y`: The absolute "line to" command.
    /// - `Q x0 y0 x y`: The absolute "quadratic spline to" command. All quadratic splines are converted to cubic splines by Figma.
    /// - `C x0 y0 x1 y1 x y`: The absolute "cubic spline to" command.
    /// - `Z`: The "close path" command.
    public let path: String
    /// Determines whether a given point in space is inside or outside the path.
    public let windingRule: WindingRule
    
    /// Determines whether a given point in space is inside or outside the path.
    ///
    /// Winding rules work off a concept called the winding number, which tells you
    /// for a given point how many times the path winds around that point.
    public enum WindingRule: String, Codable {
        /// The point is considered inside the path if the winding number is NONZERO.
        case nonZero = "NONZERO"
        /// The point is considered inside the path if the winding number is odd.
        case evenOdd = "EVENODD"
        /// An open path won’t have a fill.
        case none = "NONE"
    }
}

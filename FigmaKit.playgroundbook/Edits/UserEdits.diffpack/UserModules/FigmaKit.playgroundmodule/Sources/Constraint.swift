/// A Figma export constraint.
///
/// "Sizing constraint for exports."
/// https://www.figma.com/developers/api#constraint-type
public struct Constraint: Codable {
    /// The type of constraint to apply.
    public let type: ConstraintType
    /// See `ConstraintType` for effect of this field.
    public let value: Double
    
    public enum ConstraintType: String, Codable {
        /// Scale by `value`.
        case scale = "SCALE"
        /// Scale proportionally and set width to `value`.
        case width = "WIDTH"
        /// Scale proportionally and set height to `value`.
        case height = "HEIGHT"
    }
}

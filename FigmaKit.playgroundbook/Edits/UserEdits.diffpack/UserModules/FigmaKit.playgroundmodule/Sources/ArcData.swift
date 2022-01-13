/// A Figma arc data.
///
/// "Information about the arc properties of an ellipse. 0° is the x axis and increasing angles rotate clockwise."
/// https://www.figma.com/developers/api#arcdata-type
public struct ArcData: Codable {
    /// Start of the sweep in radians.
    public let startingAngle: Double
    /// End of the sweep in radians.
    public let endingAngle: Double
    /// Inner radius value between 0 and 1.
    public let innerRadius: Double
}

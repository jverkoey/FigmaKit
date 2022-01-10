/// A Figma 2d vector.
///
/// https://www.figma.com/developers/api#vector-type
public struct Vector: Codable {
    /// The x coordinate of the vector.
    public let x: Double
    /// The y coordinate of the vector.
    public let y: Double
}

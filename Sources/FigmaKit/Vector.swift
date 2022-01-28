/// A Figma 2d vector.
///
/// https://www.figma.com/developers/api#vector-type
public struct Vector: Codable {
  /// The x coordinate of the vector.
  public let x: Double
  /// The y coordinate of the vector.
  public let y: Double

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Self.CodingKeys)

    self.x = try container.decodeIfPresent(Double.self, forKey: .x) ?? 0
    self.y = try container.decodeIfPresent(Double.self, forKey: .y) ?? 0
  }
}


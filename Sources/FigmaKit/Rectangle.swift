/// A Figma rectangle.
///
/// "A rectangle that expresses a bounding box in absolute coordinates".
/// https://www.figma.com/developers/api#rectangle-type
public struct Rectangle: Codable {
  /// The x coordinate of top left corner of the rectangle.
  public let x: Double
  /// The y coordinate of top left corner of the rectangle.
  public let y: Double
  /// The width of the rectangle.
  public let width: Double
  /// The height of the rectangle.
  public let height: Double
}


/// A Figma RGBA color.
///
/// https://www.figma.com/developers/api#color-type
public struct Color: Codable {
  /// The red channel value, between 0 and 1.
  public let r: Double
  /// The green channel value, between 0 and 1.
  public let g: Double
  /// The blue channel value, between 0 and 1.
  public let b: Double
  /// The alpha channel value, between 0 and 1.
  public let a: Double
}


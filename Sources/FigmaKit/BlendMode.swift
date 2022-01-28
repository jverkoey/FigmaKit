/// A Figma blend mode.
///
/// "Enum describing how layer blends with layers below."
/// https://www.figma.com/developers/api#blendmode-type
public enum BlendMode: String, Codable {
  // MARK: Normal blends
  case normal = "NORMAL"
  /// Only applicable to objects with children.
  case passThrough = "PASS_THROUGH"

  // MARK: Darken
  case darken = "DARKEN"
  case multiply = "MULTIPLY"
  case linearBurn = "LINEAR_BURN"
  case colorBurn = "COLOR_BURN"

  // MARK: Lighten
  case lighten = "LIGHTEN"
  case screen = "SCREEN"
  case linearDoge = "LINEAR_DOGE"
  case colorDoge = "COLOR_DODGE"

  // MARK: Contrast
  case overlay = "OVERLAY"
  case softLight = "SOFT_LIGHT"
  case hardLight = "HARD_LIGHT"

  // MARK: Inversion
  case difference = "DIFFERENCE"
  case exclusion = "EXCLUSION"

  // MARK: Component
  case hue = "HUE"
  case saturation = "SATURATION"
  case color = "COLOR"
  case luminosity = "LUMINOSITY"
}


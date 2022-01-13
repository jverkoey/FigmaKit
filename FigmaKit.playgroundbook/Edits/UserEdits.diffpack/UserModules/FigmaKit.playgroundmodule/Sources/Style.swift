/// A Figma style.
///
/// "A set of properties that can be applied to nodes and published. Styles for a
/// property can be created in the corresponding property's panel while editing a file.".
/// https://www.figma.com/developers/api#style-type
public struct Style: Codable {
    public let key: String
    public let name: String
    public let description: String
    public let type: StyleType
    
    /// A Figma style type
    public enum StyleType: String, Codable {
        case fill = "FILL"
        case text = "TEXT"
        case effect = "EFFECT"
        case grid = "GRID"
    }
}

/// A Figma export setting.
///
/// "Format and size to export an asset at."
/// https://www.figma.com/developers/api#exportsetting-type
public struct ExportSetting: Codable {
    /// File suffix to append to all filenames.
    public let suffix: String
    /// Image type.
    public let format: Format
    /// Constraint that determines sizing of exported asset.
    public let constraint: Constraint
    
    public enum Format: String, Codable {
        case jpg = "JPG"
        case png = "PNG"
        case svg = "SVG"
    }
}

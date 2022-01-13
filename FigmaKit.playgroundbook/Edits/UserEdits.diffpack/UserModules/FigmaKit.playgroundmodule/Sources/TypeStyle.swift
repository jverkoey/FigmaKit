/// A Figma type style.
///
/// "Metadata for character formatting."
/// https://www.figma.com/developers/api#typestyle-type
public struct TypeStyle: Codable {
    /// Whether or not text is italicized.
    public let italic: Bool
    /// Paints applied to characters.
    public let fills: [Paint]
    /// Font family of text (standard name).
    public let fontFamily: String?
    /// Numeric font weight.
    public let fontWeight: Double
    /// PostScript font name
    public let fontPostScriptName: String
    /// Font size in px.
    public let fontSize: Double
    /// Link to a URL or frame.
    public let hyperlink: Hyperlink?
    /// Space between characters in px.
    public let letterSpacing: Double
    /// Line height in px.
    public let lineHeightPx: Double
    /// Line height as a percentage of the font size.
    public let lineHeightPercentFontSize: Double
    /// The unit of the line height value specified by the user.
    public let lineHeightUnit: LineHeightUnit
    /// Space between list items in px.
    public let listSpacing: Double
    /// A map of OpenType feature flags to their enabled state.
    ///
    /// Note that some flags aren't reflected here. For example, SMCP (small caps) is still represented by the textCase field.
    public let openTypeFlags: [String: Bool]
    /// Paragraph indentation in px.
    public let paragraphIndent: Double
    /// Space between paragraphs in px.
    public let paragraphSpacing: Double
    /// Horizontal text alignment.
    public let textAlignHorizontal: TextAlignHorizontal
    /// Vertical text alignment.
    public let textAlignVertical: TextAlignVertical
    /// Dimensions along which text will auto resize.
    public let textAutoResize: TextAutoResize
    /// Text casing applied to the node.
    public let textCase: TextCase
    /// Text decoration applied to the node.
    public let textDecoration: TextDecoration
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.italic = try container.decodeIfPresent(Bool.self, forKey: .italic) ?? false
        if container.contains(.fills) {
            var fillsDecoder = try container.nestedUnkeyedContainer(forKey: .fills)
            self.fills = try Paint.decodePolymorphicArray(from: fillsDecoder)
        } else {
            self.fills = []
        }
        self.fontFamily = try container.decodeIfPresent(String.self, forKey: .fontFamily)
        self.fontWeight = try container.decode(Double.self, forKey: .fontWeight)
        self.fontPostScriptName = try container.decode(String.self, forKey: .fontPostScriptName)
        self.fontSize = try container.decode(Double.self, forKey: .fontSize)
        self.hyperlink = try container.decodeIfPresent(Hyperlink.self, forKey: .hyperlink)
        self.letterSpacing = try container.decode(Double.self, forKey: .letterSpacing)
        self.lineHeightPx = try container.decode(Double.self, forKey: .lineHeightPx)
        self.lineHeightPercentFontSize = try container.decodeIfPresent(Double.self, forKey: .lineHeightPx) ?? 100
        self.lineHeightUnit = try container.decode(LineHeightUnit.self, forKey: .lineHeightUnit)
        self.listSpacing = try container.decodeIfPresent(Double.self, forKey: .listSpacing) ?? 0
        self.openTypeFlags = try container.decodeIfPresent([String: Bool].self, forKey: .openTypeFlags) ?? [:]
        self.paragraphIndent = try container.decodeIfPresent(Double.self, forKey: .paragraphIndent) ?? 0
        self.paragraphSpacing = try container.decodeIfPresent(Double.self, forKey: .paragraphSpacing) ?? 0
        self.textAlignHorizontal = try container.decode(TextAlignHorizontal.self, forKey: .textAlignHorizontal)
        self.textAlignVertical = try container.decode(TextAlignVertical.self, forKey: .textAlignVertical)
        self.textAutoResize = try container.decodeIfPresent(TextAutoResize.self, forKey: .textAutoResize) ?? .none
        self.textCase = try container.decodeIfPresent(TextCase.self, forKey: .textCase) ?? .original
        self.textDecoration = try container.decodeIfPresent(TextDecoration.self, forKey: .textDecoration) ?? .none
    }
    
    public enum LineHeightUnit: String, Codable {
        case pixels = "PIXELS"
        case fontSizePercentage = "FONT_SIZE_%"
        case intrinsicPercentage = "INTRINSIC_%"
    }
    
    public enum TextAlignHorizontal: String, Codable {
        case left = "LEFT"
        case right = "RIGHT"
        case center = "CENTER"
        case justified = "JUSTIFIED"
    }
    
    public enum TextAlignVertical: String, Codable {
        case top = "TOP"
        case bottom = "BOTTOM"
        case center = "CENTER"
    }
    
    public enum TextAutoResize: String, Codable {
        case none = "NONE"
        case height = "HEIGHT"
        case widthAndHeight = "WIDTH_AND_HEIGHT"
    }
    
    public enum TextCase: String, Codable {
        case original = "ORIGINAL"
        case upper = "UPPER"
        case lower = "LOWER"
        case title = "TITLE"
        case smallCaps = "SMALL_CAPS"
        case smallCapsForced = "SMALL_CAPS_FORCED"
    }
    
    public enum TextDecoration: String, Codable {
        case none = "NONE"
        case strikethrough = "STRIKETHROUGH"
        case underline = "UNDERLINE"
    }
}


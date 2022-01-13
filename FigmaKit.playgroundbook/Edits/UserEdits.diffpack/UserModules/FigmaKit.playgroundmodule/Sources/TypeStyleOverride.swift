/// A Figma type style override.
///
/// See TypeStyle for full documentation. All properties are optional and
/// intended to override the values of a TypeStyle.
public struct TypeStyleOverride: Codable {
    public let italic: Bool?
    public let fills: [Paint]?
    public let fontFamily: String?
    public let fontWeight: Double?
    public let fontPostScriptName: String?
    public let fontSize: Double?
    public let hyperlink: Hyperlink?
    public let letterSpacing: Double?
    public let lineHeightPx: Double?
    public let lineHeightPercentFontSize: Double?
    public let lineHeightUnit: TypeStyle.LineHeightUnit?
    public let listSpacing: Double?
    public let openTypeFlags: [String: Bool]?
    public let paragraphIndent: Double?
    public let paragraphSpacing: Double?
    public let textAlignHorizontal: TypeStyle.TextAlignHorizontal?
    public let textAlignVertical: TypeStyle.TextAlignVertical?
    public let textAutoResize: TypeStyle.TextAutoResize?
    public let textCase: TypeStyle.TextCase?
    public let textDecoration: TypeStyle.TextDecoration?
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.italic = try container.decodeIfPresent(Bool.self, forKey: .italic) ?? false
        if container.contains(.fills) {
            var fillsDecoder = try container.nestedUnkeyedContainer(forKey: .fills)
            self.fills = try Paint.decodePolymorphicArray(from: fillsDecoder)
        } else {
            self.fills = nil
        }
        self.fontFamily = try container.decodeIfPresent(String.self, forKey: .fontFamily)
        self.fontWeight = try container.decodeIfPresent(Double.self, forKey: .fontWeight)
        self.fontPostScriptName = try container.decodeIfPresent(String.self, forKey: .fontPostScriptName)
        self.fontSize = try container.decodeIfPresent(Double.self, forKey: .fontSize)
        self.hyperlink = try container.decodeIfPresent(Hyperlink.self, forKey: .hyperlink)
        self.letterSpacing = try container.decodeIfPresent(Double.self, forKey: .letterSpacing)
        self.lineHeightPx = try container.decodeIfPresent(Double.self, forKey: .lineHeightPx)
        self.lineHeightPercentFontSize = try container.decodeIfPresent(Double.self, forKey: .lineHeightPx)
        self.lineHeightUnit = try container.decodeIfPresent(TypeStyle.LineHeightUnit.self, forKey: .lineHeightUnit)
        self.listSpacing = try container.decodeIfPresent(Double.self, forKey: .listSpacing)
        self.openTypeFlags = try container.decodeIfPresent([String: Bool].self, forKey: .openTypeFlags)
        self.paragraphIndent = try container.decodeIfPresent(Double.self, forKey: .paragraphIndent)
        self.paragraphSpacing = try container.decodeIfPresent(Double.self, forKey: .paragraphSpacing)
        self.textAlignHorizontal = try container.decodeIfPresent(TypeStyle.TextAlignHorizontal.self, forKey: .textAlignHorizontal)
        self.textAlignVertical = try container.decodeIfPresent(TypeStyle.TextAlignVertical.self, forKey: .textAlignVertical)
        self.textAutoResize = try container.decodeIfPresent(TypeStyle.TextAutoResize.self, forKey: .textAutoResize)
        self.textCase = try container.decodeIfPresent(TypeStyle.TextCase.self, forKey: .textCase)
        self.textDecoration = try container.decodeIfPresent(TypeStyle.TextDecoration.self, forKey: .textDecoration)
    }
}

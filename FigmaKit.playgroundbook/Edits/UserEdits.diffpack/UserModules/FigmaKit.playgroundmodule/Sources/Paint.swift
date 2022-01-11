
/// A Figma Paint.
///
/// "A solid color, gradient, or image texture that can be applied as
/// fills or strokes."
/// https://www.figma.com/developers/api#paint-type
public class Paint: PolymorphicDecodable, CustomStringConvertible {
    public let type: FigmaType
    public let visible: Bool = true
    public let opacity: Double = 1
    
    /// Decodes an array of Paint types from an unkeyed container.
    ///
    /// The returned array's values will be instances of the corresponding type of
    /// paint.
    public static func decode(from decoder: UnkeyedDecodingContainer) throws -> [Paint] {
        return try decodePolyType(from: decoder, keyedBy: Paint.CodingKeys.self, key: .type, typeMap: Paint.typeMap)
    }
    
    static let typeMap: [FigmaType: Paint.Type] = [
        .solid: Solid.self,
    ]
    
    public enum FigmaType: String, Codable {
        case solid = "SOLID"
        case linearGradient = "GRADIENT_LINEAR"
        case radialGradient = "GRADIENT_RADIAL"
        case angularGradient = "GRADIENT_ANGULAR"
        case diamondGradient = "GRADIENT_DIAMOND"
        case image = "IMAGE"
        case emoji = "EMOJI"
    }
    
    public var description: String {
        return """
            <\(Swift.type(of: self))
            - type: \(type)
            - visible: \(visible)
            - opacity: \(opacity)
            \(paintDescription.isEmpty ? "" : "\n" + paintDescription)
            >
            """
    }
    
    var paintDescription: String {
        return ""
    }
}

extension Paint {
    /// A Figma solid fill paint.
    public class Solid: Paint {
        /// The fill's color.
        public let color: Color
        
        private enum CodingKeys: String, CodingKey {
            case color
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.color = try keyedDecoder.decode(Color.self, forKey: .color)
            
            try super.init(from: decoder)
        }
        
        override var paintDescription: String {
            return """
                - color: \(color)
                """
        }
    }
}
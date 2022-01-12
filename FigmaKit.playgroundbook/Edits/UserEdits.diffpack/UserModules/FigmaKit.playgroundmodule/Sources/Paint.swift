
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
        .image: Image.self,
        .linearGradient: Gradient.self,
        .radialGradient: Gradient.self,
        .angularGradient: Gradient.self,
        .diamondGradient: Gradient.self,
        .emoji: Emoji.self,
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
    public final class Solid: Paint {
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
    
    /// A Figma image paint.
    public final class Image: Paint {
        /// The scaling mode to use for the image.
        public let scaleMode: ScaleMode
        /// Affine transform applied to the image, only present if scaleMode is .stretch.
        public let imageTransform: Transform?
        /// Amount image is scaled by in tiling, only present if scaleMode is .tile.
        public let scalingFactor: Double?
        /// Image rotation, in degrees.
        public let rotation: Double
        /// A reference to an image embedded in this node.
        ///
        /// To download the image using this reference, use the GET file images endpoint
        /// to retrieve the mapping from image references to image URLs.
        public let imageRef: String
        /// A reference to the GIF embedded in this node, if the image is a GIF.
        ///
        /// To download the image using this reference, use the GET file images endpoint
        /// to retrieve the mapping from image references to image URLs.
        public let gifRef: String?
        
        public enum ScaleMode: String, Codable {
            case fill = "FILL"
            case fit = "FIT"
            case tile = "TILE"
            case stretch = "STRETCH"
        }
        
        private enum CodingKeys: String, CodingKey {
            case scaleMode
            case imageTransform
            case scalingFactor
            case rotation
            case imageRef
            case gifRef
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.scaleMode = try keyedDecoder.decode(ScaleMode.self, forKey: .scaleMode)
            self.imageTransform = try keyedDecoder.decodeIfPresent(Transform.self, forKey: .imageTransform)
            self.scalingFactor = try keyedDecoder.decodeIfPresent(Double.self, forKey: .scalingFactor)
            self.rotation = try keyedDecoder.decodeIfPresent(Double.self, forKey: .rotation) ?? 0
            self.imageRef = try keyedDecoder.decode(String.self, forKey: .imageRef)
            self.gifRef = try keyedDecoder.decodeIfPresent(String.self, forKey: .gifRef)
            
            try super.init(from: decoder)
        }
        
        override var paintDescription: String {
            return """
                - scaleMode: \(scaleMode)
                - imageTransform: \(imageTransform)
                - scalingFactor: \(scalingFactor)
                - rotation: \(rotation)
                - imageRef: \(imageRef)
                - gifRef: \(gifRef)
                """
        }
    }
    
    /// A Figma gradient.
    public final class Gradient: Paint {
    }
    
    /// A Figma gradient.
    public final class Emoji: Paint {
    }
}

/// A Figma effect.
///
/// "A visual effect such as a shadow or blur."
/// https://www.figma.com/developers/api#effect-type
public class Effect: PolymorphicDecodable {
    /// The Type of effect.
    public let type: EffectType
    /// Is the effect active?
    public let visible: Bool
    /// Radius of the blur effect (applies to shadows as well).
    public let radius: Double
    
    private enum CodingKeys: String, CodingKey {
        case type
        case visible
        case radius
    }
    
    public required init(from decoder: Decoder) throws {
        let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
        
        self.type = try keyedDecoder.decode(EffectType.self, forKey: .type)
        self.visible = try keyedDecoder.decode(Bool.self, forKey: .visible)
        self.radius = try keyedDecoder.decode(Double.self, forKey: .radius)
    }
    
    public static func decodePolymorphicArray(from decoder: UnkeyedDecodingContainer) throws -> [Effect] {
        return try decodePolyType(from: decoder, keyedBy: Effect.CodingKeys.self, key: .type, typeMap: Effect.typeMap)
    }
    
    static let typeMap: [EffectType: Effect.Type] = [
        .innerShadow: Shadow.self,
        .dropShadow: DropShadow.self,
        .layerBlur: Effect.self,
        .backgroundBlur: Effect.self,
    ]
    
    public enum EffectType: String, Codable {
        case innerShadow = "INNER_SHADOW"
        case dropShadow = "DROP_SHADOW"
        case layerBlur = "LAYER_BLUR"
        case backgroundBlur = "BACKGROUND_BLUR"
    }
    
    public var description: String {
        return """
            <\(Swift.type(of: self))
            - type: \(type)
            - visible: \(visible)
            - radius: \(radius)
            \(effectDescription.isEmpty ? "" : "\n" + effectDescription)
            >
            """
    }
    
    var effectDescription: String {
        return ""
    }
}

extension Effect {
    /// A Figma shadow effect.
    public final class Shadow: Effect {
        /// The color of the shadow.
        public let color: Color
        /// The blend mode of the shadow.
        public let blendMode: BlendMode
        /// How far the shadow is projected in the x and y directions.
        public let offset: Vector
        /// How far the shadow spreads.
        public let spread: Double
        
        private enum CodingKeys: String, CodingKey {
            case color
            case blendMode
            case offset
            case spread
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.color = try keyedDecoder.decode(Color.self, forKey: .color)
            self.blendMode = try keyedDecoder.decode(BlendMode.self, forKey: .blendMode)
            self.offset = try keyedDecoder.decode(Vector.self, forKey: .offset)
            self.spread = try keyedDecoder.decodeIfPresent(Double.self, forKey: .spread) ?? 0
            
            try super.init(from: decoder)
        }
        
        override var effectDescription: String {
            return """
                - color: \(color)
                - blendMode: \(blendMode)
                - offset: \(offset)
                - spread: \(spread)
                """
        }
    }
    
    /// A Figma drop shadow effect.
    public final class DropShadow: Effect {
        /// Whether to show the shadow behind translucent or transparent pixels.
        public let showShadowBehindNode: Bool
        
        private enum CodingKeys: String, CodingKey {
            case showShadowBehindNode
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.showShadowBehindNode = try keyedDecoder.decode(Bool.self, forKey: .showShadowBehindNode)
            
            try super.init(from: decoder)
        }
        
        override var effectDescription: String {
            return super.effectDescription + """
                
                - showShadowBehindNode: \(showShadowBehindNode)
                """
        }
    }
}

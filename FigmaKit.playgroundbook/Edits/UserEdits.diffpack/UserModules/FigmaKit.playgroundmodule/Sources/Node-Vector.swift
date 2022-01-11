extension Node {
    public class Vector: Node {
        public let absoluteBoundingBox: FigmaKit.Rectangle
        public let relativeTransform: Transform
        public let size: FigmaKit.Vector
        public let fills: [Paint]
        
        private enum CodingKeys: String, CodingKey {
            case absoluteBoundingBox
            case relativeTransform
            case size
            case fills
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.absoluteBoundingBox = try keyedDecoder.decode(FigmaKit.Rectangle.self, forKey: .absoluteBoundingBox)
            self.relativeTransform = try keyedDecoder.decode(Transform.self, forKey: .relativeTransform)
            self.size = try keyedDecoder.decode(FigmaKit.Vector.self, forKey: .size)
            
            if keyedDecoder.contains(.fills) {
                var fillsDecoder = try keyedDecoder.nestedUnkeyedContainer(forKey: .fills)
                self.fills = try Paint.decode(from: fillsDecoder)
            } else {
                self.fills = []
            }
            
            try super.init(from: decoder)
        }
        
        public override func encode(to encoder: Encoder) throws {
            fatalError("Not yet implemented")
        }
        
        override var contentDescription: String {
            return """
                - absoluteBoundingBox: \(absoluteBoundingBox)
                - relativeTransform: \(relativeTransform)
                - size: \(size)
                - fills:
                \(fills.debugDescription.indented(by: 2))
                """
        }
    }
}

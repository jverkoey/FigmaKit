extension Node {
    public final class Rectangle: Vector {
        /// Radius of each corner of the rectangle if a single radius is set for all corners.
        public let cornerRadius: Double?
        /// Array of length 4 of the radius of each corner of the rectangle, starting in the top left and proceeding clockwise.
        public let rectangleCornerRadii: CornerRadii?
        
        private enum CodingKeys: String, CodingKey {
            case cornerRadius
            case rectangleCornerRadii
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.cornerRadius = try keyedDecoder.decodeIfPresent(Double.self, forKey: .cornerRadius)
            self.rectangleCornerRadii = try keyedDecoder.decodeIfPresent(CornerRadii.self, forKey: .rectangleCornerRadii)
            
            try super.init(from: decoder)
        }
        
        override var contentDescription: String {
            return super.contentDescription + """
                
                - cornerRadius: \(cornerRadius)
                - rectangleCornerRadii: \(rectangleCornerRadii)
                """
        }
        
        public struct CornerRadii: Codable {
            public let topLeft: Double
            public let topRight: Double
            public let bottomRight: Double
            public let bottomLeft: Double
            
            public init(from decoder: Decoder) throws {
                var arrayDecoder = try decoder.unkeyedContainer()
                
                self.topLeft = try arrayDecoder.decode(Double.self)
                self.topRight = try arrayDecoder.decode(Double.self)
                self.bottomRight = try arrayDecoder.decode(Double.self)
                self.bottomLeft = try arrayDecoder.decode(Double.self)
            }
        }
    }
}

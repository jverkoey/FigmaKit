extension Node {
    public final class Ellipse: Vector {
        /// Start and end angles of the ellipse measured clockwise from the x axis, plus the inner radius for donuts.
        public let arcData: ArcData
        
        private enum CodingKeys: String, CodingKey {
            case arcData
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.arcData = try keyedDecoder.decode(ArcData.self, forKey: .arcData)
            
            try super.init(from: decoder)
        }
        
        override var contentDescription: String {
            return super.contentDescription + """
                
                - arcData: \(arcData)
                """
        }
    }
}

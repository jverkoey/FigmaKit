extension Node {
    public final class Canvas: Node {
        public let backgroundColor: Color
        
        private enum CodingKeys: String, CodingKey {
            case backgroundColor
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.backgroundColor = try keyedDecoder.decode(Color.self, forKey: .backgroundColor)
            
            try super.init(from: decoder)
        }
        
        public override func encode(to encoder: Encoder) throws {
            fatalError("Not yet implemented")
        }
        
        override var contentDescription: String {
            return """
                - backgroundColor: \(backgroundColor)
                """
        }
    }
}

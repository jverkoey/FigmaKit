extension Node {
    public final class Text: Vector {
        public let characters: String
        public let style: Style
        
        private enum CodingKeys: String, CodingKey {
            case characters
            case style
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.characters = try keyedDecoder.decode(String.self, forKey: .characters)
            self.style = try keyedDecoder.decode(Style.self, forKey: .style)
            
            try super.init(from: decoder)
        }
        
        override var contentDescription: String {
            return super.contentDescription + """
                - characters: \(characters)
                - style: \(style)
                """
        }
        
        public struct Style: Codable {
            public let fontFamily: String
            public let fontSize: Double
        }
        
    }
}

extension Node {
    public final class Text: Vector {
        /// Text contained within a text box.
        public let characters: String
        /// Style of text including font family and weight.
        public let style: TypeStyle
        /// Array with same number of elements as characeters in text box.
        ///
        /// Each element is a reference to the styleOverrideTable and maps to the
        /// corresponding character in the characters field.
        ///
        /// Elements with value 0 have the default type style.
        public let characterStyleOverrides: [Int]
        /// Map from ID to TypeStyle for looking up style overrides.
        public let styleOverrideTable: [Int: TypeStyleOverride]
        
        private enum CodingKeys: String, CodingKey {
            case characters
            case style
            case characterStyleOverrides
            case styleOverrideTable
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.characters = try keyedDecoder.decode(String.self, forKey: .characters)
            self.style = try keyedDecoder.decode(TypeStyle.self, forKey: .style)
            self.characterStyleOverrides = try keyedDecoder.decode([Int].self, forKey: .characterStyleOverrides)
            self.styleOverrideTable = try keyedDecoder.decodeIfPresent([Int: TypeStyleOverride].self, forKey: .styleOverrideTable) ?? [:]
            
            try super.init(from: decoder)
        }
        
        override var contentDescription: String {
            return super.contentDescription + """
                
                - characters: \(characters)
                - style: \(style)
                - characterStyleOverrides: \(characterStyleOverrides)
                - styleOverrideTable: \(styleOverrideTable)
                """
        }
    }
}

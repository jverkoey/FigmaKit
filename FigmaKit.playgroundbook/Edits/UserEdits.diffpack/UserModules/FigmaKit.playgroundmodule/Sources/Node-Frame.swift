extension Node {
    public class Frame: Vector {
        /// Whether or not this node clip content outside of its bounds.
        public let clipsContent: Bool
        /// If true, layer is locked and cannot be edited.
        public let locked: Bool
        /// The weight of strokes on the node.
        public let strokeWeight: Double
        
        private enum CodingKeys: String, CodingKey {
            case clipsContent
            case locked
            case strokeWeight
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.clipsContent = try keyedDecoder.decode(Bool.self, forKey: .clipsContent)
            self.locked = try keyedDecoder.decodeIfPresent(Bool.self, forKey: .locked) ?? false
            self.strokeWeight = try keyedDecoder.decode(Double.self, forKey: .strokeWeight)
            
            try super.init(from: decoder)
        }
        
        override var contentDescription: String {
            return super.contentDescription + """
                
                - clipsContent: \(clipsContent)
                - locked: \(locked)
                - strokeWeight: \(strokeWeight)
                """
        }
    }
}

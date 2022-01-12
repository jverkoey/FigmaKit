extension Node {
    public final class BooleanOperation: Vector {
        let booleanOperation: Operation
        enum Operation: String, Decodable {
            case union = "UNION"
            case intersect = "INTERSECT"
            case subtract = "SUBTRACT"
            case exclude = "EXCLUDE"
        }
        
        private enum CodingKeys: String, CodingKey {
            case booleanOperation
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.booleanOperation = try keyedDecoder.decode(Operation.self, forKey: .booleanOperation)
            
            try super.init(from: decoder)
        }
        
        public override func encode(to encoder: Encoder) throws {
            fatalError("Not yet implemented")
        }
        
        override var contentDescription: String {
            return """
                - booleanOperation: \(booleanOperation)
                """
        }
    }
}

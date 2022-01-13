extension Node {
    public final class Canvas: Node {
        /// Background color of the canvas.
        public let backgroundColor: Color
        /// An array of flow starting points sorted by its position in the prototype settings panel.
        public let flowStartingPoints: [FlowStartingPoint]
        /// An array of export settings representing images to export from the canvas.
        public let exportSettings: [ExportSetting]
        
        private enum CodingKeys: String, CodingKey {
            case backgroundColor
            case flowStartingPoints
            case exportSettings
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.backgroundColor = try keyedDecoder.decode(Color.self, forKey: .backgroundColor)
            self.flowStartingPoints = try keyedDecoder.decodeIfPresent([FlowStartingPoint].self, forKey: .flowStartingPoints) ?? []
            self.exportSettings = try keyedDecoder.decodeIfPresent([ExportSetting].self, forKey: .exportSettings) ?? []
            
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

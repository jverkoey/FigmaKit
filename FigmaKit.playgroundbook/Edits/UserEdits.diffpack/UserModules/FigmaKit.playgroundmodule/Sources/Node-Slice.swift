extension Node {
    public final class Slice: Node {
        /// Bounding box of the node in absolute space coordinates.
        public let absoluteBoundingBox: FigmaKit.Rectangle
        /// An array of export settings representing images to export from the node.
        public let exportSettings: [ExportSetting]
        /// The top two rows of a matrix that represents the 2D transform of this node relative to its parent.
        ///
        /// The bottom row of the matrix is implicitly always (0, 0, 1). Use to transform coordinates in geometry.
        public let relativeTransform: Transform
        /// Width and height of element.
        ///
        /// This is different from the width and height of the bounding box in that the absolute bounding box
        /// represents the element after scaling and rotation.
        public let size: FigmaKit.Vector
        
        private enum CodingKeys: String, CodingKey {
            case absoluteBoundingBox
            case exportSettings
            case relativeTransform
            case size
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.absoluteBoundingBox = try keyedDecoder.decode(FigmaKit.Rectangle.self, forKey: .absoluteBoundingBox)
            self.exportSettings = try keyedDecoder.decodeIfPresent([ExportSetting].self, forKey: .exportSettings) ?? []
            self.relativeTransform = try keyedDecoder.decode(Transform.self, forKey: .relativeTransform)
            self.size = try keyedDecoder.decode(FigmaKit.Vector.self, forKey: .size)
            
            try super.init(from: decoder)
        }
        
        public override func encode(to encoder: Encoder) throws {
            fatalError("Not yet implemented")
        }
        
        override var contentDescription: String {
            return """
                - absoluteBoundingBox: \(absoluteBoundingBox)
                - exportSettings:
                \(exportSettings.description.indented(by: 2))
                - relativeTransform: \(relativeTransform)
                - size: \(size)
                """
        }
    }
}

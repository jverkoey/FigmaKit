extension Node {
    /// A Figma Vector node.
    ///
    /// https://www.figma.com/developers/api#vector-props
    public class Vector: Node {
        /// Bounding box of the node in absolute space coordinates.
        public let absoluteBoundingBox: FigmaKit.Rectangle
        /// How this node blends with nodes behind it in the scene.
        public let blendMode: BlendMode
        /// Horizontal and vertical layout constraints for node.
        public let constraints: LayoutConstraint
        /// An array of effects attached to this node.
        public let effects: [Effect]
        /// An array of export settings representing images to export from the node.
        public let exportSettings: [ExportSetting]
        /// An array of paths representing the object fill.
        public let fillGeometry: [Path]
        /// An array of fill paints applied to the node.
        public let fills: [Paint]
        /// Does this node mask sibling nodes in front of it?
        public let isMask: Bool
        /// Determines if the layer should stretch along the parent’s counter axis.
        /// This property is only provided for direct children of auto-layout frames.
        public let layoutAlign: LayoutAlign?
        /// This property is applicable only for direct children of auto-layout frames, ignored otherwise.
        /// Determines whether a layer should stretch along the parent’s primary axis.
        public let layoutGrow: LayoutGrow?
        /// If true, layer is locked and cannot be edited.
        public let locked: Bool
        /// Opacity of the node.
        public let opacity: Double
        /// Keep height and width constrained to same ratio.
        public let preserveRatio: Bool
        /// The top two rows of a matrix that represents the 2D transform of this node relative to its parent.
        ///
        /// The bottom row of the matrix is implicitly always (0, 0, 1). Use to transform coordinates in geometry.
        public let relativeTransform: Transform
        /// Width and height of element.
        ///
        /// This is different from the width and height of the bounding box in that the absolute bounding box
        /// represents the element after scaling and rotation.
        public let size: FigmaKit.Vector
        /// The end caps of vector paths.
        public let strokeCap: StrokeCap
        /// An array of floating point numbers describing the pattern of dash length and gap lengths that the vector path follows.
        ///
        /// For example a value of [1, 2] indicates that the path has a dash of length 1 followed by a gap of length 2, repeated.
        public let strokeDashes: [Double]
        /// An array of paths representing the object stroke.
        public let strokeGeometry: [Path]
        /// How corners in vector paths are rendered.
        public let strokeJoin: StrokeJoin
        /// An array of fill paints applied to the node.
        public let strokes: [Paint]
        /// Only valid if strokeJoin is .miter.
        ///
        /// The corner angle, in degrees, below which strokeJoin will be set to .bevel to avoid super sharp corners.
        public let strokeMiterAngle: Double
        /// The weight of strokes on the node.
        public let strokeWeight: Double
        /// A mapping of a StyleType to style ID of styles present on this node.
        ///
        /// The style ID can be used to look up more information about the style in the top-level styles field.
        public let styles: [Style.StyleType: String]
        /// The duration of the prototyping transition on this node (in milliseconds).
        public let transitionDuration: Double?
        /// The easing curve used in the prototyping transition on this node.
        public let transitionEasing: EasingType?
        /// Node ID of node to transition to in prototyping.
        public let transitionNodeID: String?
        
        private enum CodingKeys: String, CodingKey {
            case absoluteBoundingBox
            case blendMode
            case constraints
            case effects
            case exportSettings
            case fillGeometry
            case fills
            case isMask
            case layoutAlign
            case layoutGrow
            case locked
            case opacity
            case preserveRatio
            case relativeTransform
            case size
            case strokeCap
            case strokeDashes
            case strokeJoin
            case strokes
            case strokeGeometry
            case strokeMiterAngle
            case strokeWeight
            case styles
            case transitionDuration
            case transitionEasing
            case transitionNodeID
        }
        
        public required init(from decoder: Decoder) throws {
            let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
            
            self.absoluteBoundingBox = try keyedDecoder.decode(FigmaKit.Rectangle.self, forKey: .absoluteBoundingBox)
            self.blendMode = try keyedDecoder.decode(BlendMode.self, forKey: .blendMode)
            self.constraints = try keyedDecoder.decode(LayoutConstraint.self, forKey: .constraints)
            if keyedDecoder.contains(.effects) {
                var effectsDecoder = try keyedDecoder.nestedUnkeyedContainer(forKey: .effects)
                self.effects = try Effect.decodePolymorphicArray(from: effectsDecoder)
            } else {
                self.effects = []
            }
            self.exportSettings = try keyedDecoder.decodeIfPresent([ExportSetting].self, forKey: .exportSettings) ?? []
            self.fillGeometry = try keyedDecoder.decodeIfPresent([Path].self, forKey: .fillGeometry) ?? []
            if keyedDecoder.contains(.fills) {
                var fillsDecoder = try keyedDecoder.nestedUnkeyedContainer(forKey: .fills)
                self.fills = try Paint.decodePolymorphicArray(from: fillsDecoder)
            } else {
                self.fills = []
            }
            self.isMask = try keyedDecoder.decodeIfPresent(Bool.self, forKey: .isMask) ?? false
            self.layoutAlign = try keyedDecoder.decodeIfPresent(LayoutAlign.self, forKey: .layoutAlign)
            self.layoutGrow = try keyedDecoder.decodeIfPresent(LayoutGrow.self, forKey: .layoutGrow)
            self.locked = try keyedDecoder.decodeIfPresent(Bool.self, forKey: .locked) ?? false
            self.opacity = try keyedDecoder.decodeIfPresent(Double.self, forKey: .opacity) ?? 1
            self.preserveRatio = try keyedDecoder.decodeIfPresent(Bool.self, forKey: .preserveRatio) ?? false
            self.relativeTransform = try keyedDecoder.decode(Transform.self, forKey: .relativeTransform)
            self.size = try keyedDecoder.decode(FigmaKit.Vector.self, forKey: .size)
            self.strokeCap = try keyedDecoder.decodeIfPresent(StrokeCap.self, forKey: .strokeCap) ?? .none
            self.strokeDashes = try keyedDecoder.decodeIfPresent([Double].self, forKey: .strokeDashes) ?? []
            self.strokeJoin = try keyedDecoder.decodeIfPresent(StrokeJoin.self, forKey: .strokeJoin) ?? .miter
            if keyedDecoder.contains(.strokes) {
                var strokesDecoder = try keyedDecoder.nestedUnkeyedContainer(forKey: .strokes)
                self.strokes = try Paint.decodePolymorphicArray(from: strokesDecoder)
            } else {
                self.strokes = []
            }
            self.strokeGeometry = try keyedDecoder.decodeIfPresent([Path].self, forKey: .strokeGeometry) ?? []
            self.strokeMiterAngle = try keyedDecoder.decodeIfPresent(Double.self, forKey: .strokeMiterAngle) ?? 28.96
            self.strokeWeight = try keyedDecoder.decode(Double.self, forKey: .strokeWeight)
            self.styles = try keyedDecoder.decodeIfPresent([Style.StyleType: String].self, forKey: .styles) ?? [:]
            self.transitionDuration = try keyedDecoder.decodeIfPresent(Double.self, forKey: .transitionDuration)
            self.transitionEasing = try keyedDecoder.decodeIfPresent(EasingType.self, forKey: .transitionEasing)
            self.transitionNodeID = try keyedDecoder.decodeIfPresent(String.self, forKey: .transitionNodeID)
            
            try super.init(from: decoder)
        }
        
        public enum LayoutAlign: String, Codable {
            case inherit = "INHERIT"
            case stretch = "STRETCH"
        }
        public enum LayoutGrow: Int, Codable {
            case fixedSize = 0
            case stretch = 1
        }
        
        public override func encode(to encoder: Encoder) throws {
            fatalError("Not yet implemented")
        }
        
        override var contentDescription: String {
            return """
                - absoluteBoundingBox: \(absoluteBoundingBox)
                - blendMode: \(blendMode)
                - constraints: \(constraints)
                - effects:
                \(effects.description.indented(by: 2))
                - exportSettings:
                \(exportSettings.description.indented(by: 2))
                - fillGeometry: \(fillGeometry)
                - fills:
                \(fills.description.indented(by: 2))
                - layoutAlign: \(layoutAlign)
                - layoutGrow: \(layoutGrow)
                - locked: \(locked)
                - opacity: \(opacity)
                - preserveRatio: \(preserveRatio)
                - relativeTransform: \(relativeTransform)
                - size: \(size)
                - strokeCap: \(strokeCap)
                - strokeDashes: \(strokeDashes)
                - strokeJoin: \(strokeJoin)
                - strokes:
                \(strokes.description.indented(by: 2))
                - strokeGeometry: \(strokeGeometry)
                - strokeMiterAngle: \(strokeMiterAngle)
                - strokeWeight: \(strokeWeight)
                - transitionDuration: \(transitionDuration)
                - transitionEasing: \(transitionEasing)
                - transitionNodeID: \(transitionNodeID)
                """
        }
    }
}

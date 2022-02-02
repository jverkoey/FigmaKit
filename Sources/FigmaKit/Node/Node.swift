public class Node: Codable, PolymorphicDecodable, CustomDebugStringConvertible {
  /// A string uniquely identifying this node within the document.
  public let id: String
  /// The name given to the node by the user in the tool.
  public let name: String
  /// Whether or not the node is visible on the canvas.
  public let visible: Bool
  /// The type of the node, refer to table below for details.
  public let type: FigmaType
  /// The nodes that are attached to this node.
  public let children: [Node]

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case visible
    case type
    case children
  }

  public enum FigmaType: String, Codable {
    case booleanOperation = "BOOLEAN_OPERATION"
    case canvas = "CANVAS"
    case component = "COMPONENT"
    case componentSet = "COMPONENT_SET"
    case document = "DOCUMENT"
    case ellipse = "ELLIPSE"
    case frame = "FRAME"
    case group = "GROUP"
    case instance = "INSTANCE"
    case line = "LINE"
    case rectangle = "RECTANGLE"
    case regularPolygon = "REGULAR_POLYGON"
    case slice = "SLICE"
    case star = "STAR"
    case text = "TEXT"
    case vector = "VECTOR"
  }

  static let typeMap: [FigmaType: Node.Type] = [
    .booleanOperation: Node.BooleanOperationNode.self,
    .canvas: Node.CanvasNode.self,
    .component: Node.ComponentNode.self,
    .componentSet: Node.ComponentSetNode.self,
    .document: Node.DocumentNode.self,
    .ellipse: Node.EllipseNode.self,
    .frame: Node.FrameNode.self,
    .group: Node.GroupNode.self,
    .instance: Node.InstanceNode.self,
    .line: Node.LineNode.self,
    .rectangle: Node.RectangleNode.self,
    .regularPolygon: Node.RegularPolygonNode.self,
    .slice: Node.SliceNode.self,
    .star: Node.StarNode.self,
    .text: Node.TextNode.self,
    .vector: Node.VectorNode.self,
  ]

  /// Decodes an array of Paint types from an unkeyed container.
  ///
  /// The returned array's values will be instances of the corresponding type of
  /// paint.
  private static func decodePolymorphicArray(from decoder: UnkeyedDecodingContainer) throws
    -> [Node]
  {
    return try decodePolyType(
      from: decoder, keyedBy: Node.CodingKeys.self, key: .type, typeMap: Node.typeMap)
  }

  public required init(from decoder: Decoder) throws {
    let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)

    self.id = try keyedDecoder.decode(String.self, forKey: .id)
    self.name = try keyedDecoder.decode(String.self, forKey: .name)
    self.visible = try keyedDecoder.decodeIfPresent(Bool.self, forKey: .visible) ?? true
    self.type = try keyedDecoder.decode(FigmaType.self, forKey: .type)

    guard keyedDecoder.contains(.children) else {
      self.children = []
      return
    }
    let childrenDecoder = try keyedDecoder.nestedUnkeyedContainer(forKey: .children)
    self.children = try Node.decodePolymorphicArray(from: childrenDecoder)
  }

  public func encode(to encoder: Encoder) throws {
    fatalError("Not yet implemented")
  }

  public var debugDescription: String {
    return """
      <\(Swift.type(of: self))
      - id: \(id)
      - name: \(name)
      - visible: \(visible)
      - type: \(type)
      \(contentDescription.isEmpty ? "" : "\n" + contentDescription)
      children:
      \(children.debugDescription.indented(by: 2))
      >
      """
  }

  var contentDescription: String {
    return ""
  }
}

extension Node: Hashable {
  public static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

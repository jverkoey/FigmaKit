/// A Figma file node.
///
/// There is no apparent documentation for this structure on
/// https://www.figma.com/developers/api#node-types, so it was defined by inspecting the response
/// of a nodes endpoint query: https://www.figma.com/developers/api#get-file-nodes-endpoint.
public struct FileNode: Codable {
  /// The version of this node's Figma file's schema.
  public let schemaVersion: Int
  /// The root of the node that was requested.
  public let document: Node
  /// A map of components that are referenced in the node's tree.
  public let components: [String: Component]
  /// A map of component sets that are present in the node's tree.
  public let componentSets: [String: ComponentSet]
  /// A map of styles that are referenced in the node's tree.
  public let styles: [String: Style]

  public init(from decoder: Decoder) throws {
    let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)

    self.schemaVersion = try keyedDecoder.decode(Int.self, forKey: .schemaVersion)
    self.components = try keyedDecoder.decode([String: Component].self, forKey: .components)
    self.componentSets = try keyedDecoder.decode(
      [String: ComponentSet].self, forKey: .componentSets)
    self.styles = try keyedDecoder.decode([String: Style].self, forKey: .styles)

    let nodeContainer = try keyedDecoder.nestedContainer(
      keyedBy: Node.CodingKeys.self, forKey: .document)
    let nodeType = try nodeContainer.decode(Node.FigmaType.self, forKey: .type)
    guard let itemType = Node.typeMap[nodeType] else {
      throw DecodingError.typeMismatch(
        Self.self,
        DecodingError.Context(
          codingPath: decoder.codingPath,
          debugDescription: "Unknown item type: \(nodeType)"
        )
      )
    }
    // Note that the following switch case statement is necessary because the preferred approach,
    //
    //     self.document = try decoder.decode(itemType, forKey: key)
    //
    // does not return the node as the desired nodeType, it decodes and returns the node as Node
    // type instead. This seems likely to be a Swift compiler/runtime bug. To work around this, we
    // need to handle the type polymorphism ourselves using an explicit switch statement.
    if itemType == Node.BooleanOperationNode.self {
      self.document = try keyedDecoder.decode(Node.BooleanOperationNode.self, forKey: .document)
    } else if itemType == Node.CanvasNode.self {
      self.document = try keyedDecoder.decode(Node.CanvasNode.self, forKey: .document)
    } else if itemType == Node.DocumentNode.self {
      self.document = try keyedDecoder.decode(Node.DocumentNode.self, forKey: .document)
    } else if itemType == Node.EllipseNode.self {
      self.document = try keyedDecoder.decode(Node.EllipseNode.self, forKey: .document)
    } else if itemType == Node.FrameNode.self {
      self.document = try keyedDecoder.decode(Node.FrameNode.self, forKey: .document)
    } else if itemType == Node.GroupNode.self {
      self.document = try keyedDecoder.decode(Node.GroupNode.self, forKey: .document)
    } else if itemType == Node.InstanceNode.self {
      self.document = try keyedDecoder.decode(Node.InstanceNode.self, forKey: .document)
    } else if itemType == Node.LineNode.self {
      self.document = try keyedDecoder.decode(Node.LineNode.self, forKey: .document)
    } else if itemType == Node.RectangleNode.self {
      self.document = try keyedDecoder.decode(Node.RectangleNode.self, forKey: .document)
    } else if itemType == Node.RegularPolygonNode.self {
      self.document = try keyedDecoder.decode(Node.RegularPolygonNode.self, forKey: .document)
    } else if itemType == Node.SectionNode.self {
      self.document = try keyedDecoder.decode(Node.SectionNode.self, forKey: .document)
    } else if itemType == Node.SliceNode.self {
      self.document = try keyedDecoder.decode(Node.SliceNode.self, forKey: .document)
    } else if itemType == Node.StarNode.self {
      self.document = try keyedDecoder.decode(Node.StarNode.self, forKey: .document)
    } else if itemType == Node.TextNode.self {
      self.document = try keyedDecoder.decode(Node.TextNode.self, forKey: .document)
    } else if itemType == Node.VectorNode.self {
      self.document = try keyedDecoder.decode(Node.VectorNode.self, forKey: .document)
    } else {
      fatalError("Unhandled node type: \(itemType)")
    }
  }

  private static func cast<T>(value: Any, to type: T) -> T {
    return value as! T
  }
}

/// A Figma file nodes response.
///
/// This object is the response from requests to Figma's get file nodes endpoint:
/// https://www.figma.com/developers/api#get-file-nodes-endpoint.
public final class FileNodes: Codable, CustomStringConvertible {
  // MARK: Document metadata

  /// The name of the Figma document this node exists within.
  public let name: String
  /// When the document was last modified.
  public let lastModified: String
  /// The thumbnail for the document.
  public let thumbnailUrl: String
  /// The requestor's access privileges for the document.
  public let role: File.Role
  /// The document's version at the time of request.
  public let version: String
  /// Who is able to view the document.
  public let linkAccess: File.LinkAccess

  // MARK: Requested nodes

  /// A mapping of the requested node keys to the corresponding file nodes.
  public let nodes: [String: FileNode]

  public required init(from decoder: Decoder) throws {
    let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)

    self.name = try keyedDecoder.decode(String.self, forKey: .name)
    self.lastModified = try keyedDecoder.decode(String.self, forKey: .lastModified)
    self.thumbnailUrl = try keyedDecoder.decode(String.self, forKey: .thumbnailUrl)
    self.role = try keyedDecoder.decode(File.Role.self, forKey: .role)
    self.version = try keyedDecoder.decode(String.self, forKey: .version)
    self.linkAccess = try keyedDecoder.decode(File.LinkAccess.self, forKey: .linkAccess)
    self.nodes = try keyedDecoder.decode([String: FileNode].self, forKey: .nodes)
  }

  public var description: String {
    return """
      <File
      - name: \(name)
      - lastModified: \(lastModified)
      - thumbnailUrl: \(thumbnailUrl)
      - role: \(role)
      - version: \(version)
      - linkAccess: \(linkAccess)
      - nodes:
      \(nodes)
      >
      """
  }
}

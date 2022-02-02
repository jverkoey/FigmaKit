/// A Figma file node.
///
/// There is no apparent documentation for this structure on
/// https://www.figma.com/developers/api#node-types, so it was defined by inspecting the response
/// of a nodes endpoint query: https://www.figma.com/developers/api#get-file-nodes-endpoint.
public struct FileNode: Codable {
  /// The version of this node's Figma file's schema.
  public let schemaVersion: Int
  /// The root of the node that was requested.
  public let document: Node.DocumentNode
  /// A map of components that are referenced in the node's tree.
  public let components: [String: Component]
  /// A map of component sets that are present in the node's tree.
  public let componentSets: [String: ComponentSet]
  /// A map of styles that are referenced in the node's tree.
  public let styles: [String: Style]
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

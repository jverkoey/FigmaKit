public final class File: Codable, CustomStringConvertible {
  public let name: String
  public let lastModified: String
  public let thumbnailUrl: String
  public let schemaVersion: Int
  public let role: Role
  public let version: String
  public let linkAccess: LinkAccess
  public let document: Node.DocumentNode
  public let components: [String: Component]
  public let componentSets: [String: ComponentSet]
  public let styles: [String: Style]

  public required init(from decoder: Decoder) throws {
    let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)

    self.name = try keyedDecoder.decode(String.self, forKey: .name)
    self.lastModified = try keyedDecoder.decode(String.self, forKey: .lastModified)
    self.thumbnailUrl = try keyedDecoder.decode(String.self, forKey: .thumbnailUrl)
    self.schemaVersion = try keyedDecoder.decode(Int.self, forKey: .schemaVersion)
    self.role = try keyedDecoder.decode(Role.self, forKey: .role)
    self.version = try keyedDecoder.decode(String.self, forKey: .version)
    self.linkAccess = try keyedDecoder.decode(LinkAccess.self, forKey: .linkAccess)
    self.document = try keyedDecoder.decode(Node.DocumentNode.self, forKey: .document)
    self.components = try keyedDecoder.decodeIfPresent([String: Component].self, forKey: .components) ?? [:]
    self.componentSets = try keyedDecoder.decodeIfPresent([String: ComponentSet].self, forKey: .componentSets) ?? [:]
    self.styles = try keyedDecoder.decode([String: Style].self, forKey: .styles)
  }

  public enum Role: String, Codable {
    case owner = "owner"
    case editor = "editor"
  }

  public enum LinkAccess: String, Codable {
    case inherit = "inherit"
    case view = "view"
    case edit = "edit"
    case orgView = "org_view"
    case orgEdit = "org_edit"
  }

  public var description: String {
    return """
            <File
            - name: \(name)
            - lastModified: \(lastModified)
            - thumbnailUrl: \(thumbnailUrl)
            - schemaVersion: \(schemaVersion)
            - role: \(role)
            - version: \(version)
            - linkAccess: \(linkAccess)
            - styles: \(styles)
            - document:
            \(document.debugDescription.indented(by: 2))
            >
            """
  }
}


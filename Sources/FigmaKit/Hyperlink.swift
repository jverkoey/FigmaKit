/// A Figma hyperlink.
///
/// "A link to either a URL or another frame (node) in the document."
/// https://www.figma.com/developers/api#hyperlink-type
public enum Hyperlink: Codable {
  case none
  case url(String)
  case node(String)

  private enum CodingKeys: String, CodingKey {
    case type
    case url
    case nodeID
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Self.CodingKeys)

    if let type = try container.decodeIfPresent(HyperlinkType.self, forKey: .type) {
      switch type {
      case .url:
        self = .url(try container.decode(String.self, forKey: .url))
      case .node:
        self = .node(try container.decode(String.self, forKey: .nodeID))
      }
    } else {
      self = .none
    }
  }

  public func encode(to encoder: Encoder) throws {
    fatalError("Not implemented")
  }

  public enum HyperlinkType: String, Codable {
    case url = "URL"
    case node = "NODE"
  }
}


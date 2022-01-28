extension Node {
  public final class InstanceNode: FrameNode {
    /// ID of component that this instance came from, refers to components table.
    public let componentId: String

    private enum CodingKeys: String, CodingKey {
      case componentId
    }

    public required init(from decoder: Decoder) throws {
      let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)

      self.componentId = try keyedDecoder.decode(String.self, forKey: .componentId)

      try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
      fatalError("Not yet implemented")
    }

    override var contentDescription: String {
      return """
                - componentId: \(componentId)
                """
    }
  }
}


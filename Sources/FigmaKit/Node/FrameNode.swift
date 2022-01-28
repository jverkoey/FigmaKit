extension Node {
  public class FrameNode: VectorNode {
    /// Whether or not this node clip content outside of its bounds.
    public let clipsContent: Bool

    private enum CodingKeys: String, CodingKey {
      case clipsContent
    }

    public required init(from decoder: Decoder) throws {
      let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)

      self.clipsContent = try keyedDecoder.decode(Bool.self, forKey: .clipsContent)

      try super.init(from: decoder)
    }

    override var contentDescription: String {
      return super.contentDescription + """

                - clipsContent: \(clipsContent)
                """
    }
  }
}


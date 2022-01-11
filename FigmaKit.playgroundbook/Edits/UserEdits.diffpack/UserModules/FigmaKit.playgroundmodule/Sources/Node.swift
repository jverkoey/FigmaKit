public class Node: Codable, PolymorphicDecodable, CustomDebugStringConvertible {
    public let id: String
    public let name: String
    public let type: FigmaType
    public let children: [Node]
    
    public enum FigmaType: String, Codable {
        case document = "DOCUMENT"
        case rectangle = "RECTANGLE"
        case canvas = "CANVAS"
        case text = "TEXT"
    }
    
    static let typeMap: [FigmaType: Node.Type] = [
        .document: Document.self,
        .canvas: Canvas.self,
        .rectangle: Rectangle.self,
        .text: Text.self
    ]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case children
    }
    
    /// Decodes an array of Paint types from an unkeyed container.
    ///
    /// The returned array's values will be instances of the corresponding type of
    /// paint.
    private static func decode(from decoder: UnkeyedDecodingContainer) throws -> [Node] {
        return try decodePolyType(from: decoder, keyedBy: Node.CodingKeys.self, key: .type, typeMap: Node.typeMap)
    }
    
    public required init(from decoder: Decoder) throws {
        let keyedDecoder = try decoder.container(keyedBy: Self.CodingKeys)
        
        self.id = try keyedDecoder.decode(String.self, forKey: .id)
        self.name = try keyedDecoder.decode(String.self, forKey: .name)
        self.type = try keyedDecoder.decode(FigmaType.self, forKey: .type)
        
        guard keyedDecoder.contains(.children) else {
            self.children = []
            return
        }
        var childrenDecoder = try keyedDecoder.nestedUnkeyedContainer(forKey: .children)
        self.children = try Node.decode(from: childrenDecoder)
    }
    
    public func encode(to encoder: Encoder) throws {
        fatalError("Not yet implemented")
    }
    
    public var debugDescription: String {
        return """
            <\(Swift.type(of: self))
            - id: \(id)
            - name: \(name)
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
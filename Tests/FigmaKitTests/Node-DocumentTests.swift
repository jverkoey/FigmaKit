import FigmaKit
import Foundation
import XCTest

private struct TestObject: Decodable {
    let paints: [Paint]
    
    private enum CodingKeys: String, CodingKey {
        case paints
    }
    
    init(from decoder: Decoder) throws { 
        let container = try decoder.container(keyedBy: Self.CodingKeys)
        self.paints = try Paint.decodePolymorphicArray(from: container.nestedUnkeyedContainer(forKey: .paints))
    }
}

public final class NodeDocumentTests: XCTestCase {
    public func testDecodingWithNoChildren() throws {
        let json = """
            {
                "id": "test",
                "name": "document",
                "type": "DOCUMENT",
            }
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let object = try decoder.decode(Node.DocumentNode.self, from: json)
        
        XCTAssertEqual(object.id, "test")
        XCTAssertEqual(object.type, .document)
        XCTAssertEqual(object.name, "document")
        XCTAssertTrue(object.visible)
        XCTAssertTrue(object.children.isEmpty)
    }
}
